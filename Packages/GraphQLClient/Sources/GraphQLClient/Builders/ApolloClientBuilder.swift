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

struct ApolloClientBuilder {
  func client(for service: Service) -> ApolloClientProtocol {
    let store = self.store()
    let urlClient = self.urlClient()
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
    .init()
  }

  private func urlClient() -> URLSessionClient {
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
