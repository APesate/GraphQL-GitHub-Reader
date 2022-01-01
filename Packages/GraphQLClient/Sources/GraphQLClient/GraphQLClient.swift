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
  private let responseParser: ResponseParserProtocol

  public init(service: Service, client: ApolloClientProtocol, cachePolice: CachePoliceProtocol, responseParser: ResponseParserProtocol) {
    self.service = service
    self.client = client
    self.cachePolice = cachePolice
    self.responseParser = responseParser
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
        let parsedData: Response = try self.responseParser.parse(result: data)
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

    client.clearCache(callbackQueue: .main, completion: nil)
  }
}
