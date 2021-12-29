//
//  GraphQLClient.swift
//  GraphQLClient
//
//  Created by Andrés Pesate on 29/12/2021.
//

import Foundation
import protocol Apollo.ApolloClientProtocol
import protocol Apollo.GraphQLQuery

public class GraphQLClient: GraphQLClientProtocol {
  private let service: Service
  private let client: ApolloClientProtocol
  private let networkQueue: DispatchQueue

  public init(service: Service, client: ApolloClientProtocol) {
    self.service = service
    self.client = client
    networkQueue = DispatchQueue(
      label: "\(#file)_queue",
      qos: .userInitiated
    )
  }

  // MARK: - Interface

  public func get<Query: GraphQLQuery, Response: Decodable>(
    query: Query,
    completionHandler: @escaping (Result<Response?, Error>) -> Void
  ) {
    _ = client.fetch(
      query: query,
      cachePolicy: .returnCacheDataElseFetch,
      contextIdentifier: UUID(),
      queue: networkQueue
    ) { result in
      switch result {
      case .success:
        completionHandler(.success(nil))
      case let .failure(error):
        completionHandler(.failure(error))
      }
    }
  }
}
