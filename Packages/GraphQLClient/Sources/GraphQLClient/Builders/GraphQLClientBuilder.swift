//
//  GraphQLClientBuilder.swift
//  GraphQLClient
//
//  Created by Andrés Pesate on 29/12/2021.
//

import Foundation

public struct GraphQLClientBuilder {
  private let apolloClientBuilder = ApolloClientBuilder()

  public init() {}

  public func client(for service: Service, cachePolicy: CachePolicy) -> GraphQLClientProtocol {
    let apolloClient = apolloClientBuilder.client(for: service)
    return GraphQLClient(
      service: service,
      client: apolloClient,
      cachePolice: cachePolice(cachePolicy: cachePolicy)
    )
  }

  private func cachePolice(cachePolicy: CachePolicy) -> CachePoliceProtocol {
    CachePolice(
      cachePolicy: cachePolicy,
      userDefaults: userDefaults()
    )
  }

  private func userDefaults() -> UserDefaultsProtocol {
    UserDefaults.standard
  }
}
