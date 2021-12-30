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
  enum Error: Swift.Error {
    case failedToParseResponse
    case serviceError
    case noData
  }

  private let service: Service
  private let client: ApolloClientProtocol

  public init(service: Service, client: ApolloClientProtocol) {
    self.service = service
    self.client = client
  }

  // MARK: - Interface

  public func get<Query: GraphQLQuery, Response: Codable>(
    query: Query,
    completionHandler: @escaping (Result<Response, Swift.Error>) -> Void
  ) {
    _ = client.fetch(
      query: query,
      cachePolicy: .returnCacheDataElseFetch,
      contextIdentifier: UUID(),
      queue: .main
    ) { [weak self] result in
      guard let self = self, let data = try? result.get().data else {
        completionHandler(.failure(Error.serviceError))
        return
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

  // TODO: This could be extracted into its own object and injected as dependency to the client
  private func parseResponse<
    Response: Codable
  >(result: GraphQLSelectionSet?) throws -> Response {
    guard let result = result else {
      throw Error.noData
    }

    do {
      let jsonData = try JSONSerialization.data(
        withJSONObject: result.jsonObject,
        options: .fragmentsAllowed
      )
      return try JSONDecoder().decode(Response.self, from: jsonData)
    } catch {
      throw Error.failedToParseResponse
    }
  }
}
