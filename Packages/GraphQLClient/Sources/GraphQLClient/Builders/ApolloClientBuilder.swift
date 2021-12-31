//
//  ApolloClientBuilder.swift
//  GraphQLClient
//
//  Created by Andrés Pesate on 29/12/2021.
//

import class Apollo.ApolloClient
import protocol Apollo.ApolloClientProtocol
import class Apollo.ApolloStore
import class Apollo.DefaultInterceptorProvider
import protocol Apollo.InterceptorProvider
import protocol Apollo.NetworkTransport
import class Apollo.RequestChainNetworkTransport
import class Apollo.URLSessionClient
import ApolloSQLite
import Foundation

struct ApolloClientBuilder {
  private let cacheBuilder: CacheBuilder

  init(cacheBuilder: CacheBuilder = .init()) {
    self.cacheBuilder = cacheBuilder
  }

  func client(for service: Service) -> ApolloClientProtocol {
    let store = self.store()
    let urlClient = self.urlSessionClient()
    let interceptorProvider = self.interceptorProvider(
      with: urlClient,
      store: store
    )
    let networkTransport = self.networkTransport(
      for: service,
      with: interceptorProvider
    )

    return ApolloClient(
      networkTransport: networkTransport,
      store: store
    )
  }

  private func store() -> ApolloStore {
    ApolloStore(cache: cacheBuilder.build())
  }

  private func urlSessionClient() -> URLSessionClient {
    .init()
  }

  private func interceptorProvider(
    with urlClient: URLSessionClient,
    store: ApolloStore
  ) -> InterceptorProvider {
    DefaultInterceptorProvider(client: urlClient, store: store)
  }

  private func networkTransport(
    for service: Service,
    with provider: InterceptorProvider
  ) -> NetworkTransport {
    RequestChainNetworkTransport(
      interceptorProvider: provider,
      endpointURL: service.url,
      additionalHeaders: service.additionalHeaders ?? [:]
    )
  }
}
