//
//  GraphQLClientBuilder.swift
//  GraphQLClient
//
//  Created by Andrés Pesate on 29/12/2021.
//

public struct GraphQLClientBuilder {
  private let apolloClientBuilder = ApolloClientBuilder()

  public init() {}

  public func client(for service: Service) -> GraphQLClientProtocol {
    let apolloClient = apolloClientBuilder.client(for: service)
    return GraphQLClient(service: service, client: apolloClient)
  }
}
