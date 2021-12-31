//
//  GraphQLClient.swift
//  GraphQLClient
//
//  Created by Andrés Pesate on 29/12/2021.
//

import protocol Apollo.ApolloClientProtocol
import protocol Apollo.GraphQLQuery
import struct Apollo.GraphQLResult
import protocol Apollo.GraphQLSelectionSet
import Foundation

public class GraphQLClient: GraphQLClientProtocol {
  private let service: Service
  private let client: ApolloClientProtocol
  private let cachePolice: CachePoliceProtocol

  public init(service: Service, client: ApolloClientProtocol, cachePolice: CachePoliceProtocol) {
    self.service = service
    self.client = client
    self.cachePolice = cachePolice
  }

  // MARK: - Interface

  public func get<Query: GraphQLQuery, Response: Codable>(
    query: Query,
    completionHandler: @escaping (Result<Response, Swift.Error>) -> Void
  ) {
    resetCacheIfNeeded()

    _ = client.fetch(
      query: query,
      cachePolicy: .returnCacheDataElseFetch,
      contextIdentifier: UUID(),
      queue: .main
    ) { [weak self] result in
      guard let self = self,
            let result = try? result.get(),
            let data = result.data
      else {
        completionHandler(.failure(GraphQLClientError.serviceError))
        return
      }

      if result.source == .server {
        self.cachePolice.didUpdateCache()
      }

      do {
        let parsedData: Response = try self.parseResponse(result: data)
        completionHandler(.success(parsedData))
      } catch {
        completionHandler(.failure(error))
      }
    }
  }

  // MARK: - Private

  private func resetCacheIfNeeded() {
    guard !cachePolice.isCacheValid else {
      return
    }

    client.store.clearCache()
  }

  // TODO: This could be extracted into its own object and injected as dependency to the client
  private func parseResponse<
    Response: Codable
  >(result: GraphQLSelectionSet?) throws -> Response {
    guard let result = result else {
      throw GraphQLClientError.noData
    }

    do {
      let jsonData = try JSONSerialization.data(
        withJSONObject: result.jsonObject,
        options: .fragmentsAllowed
      )
      return try JSONDecoder().decode(Response.self, from: jsonData)
    } catch {
      throw GraphQLClientError.failedToParseResponse
    }
  }
}
