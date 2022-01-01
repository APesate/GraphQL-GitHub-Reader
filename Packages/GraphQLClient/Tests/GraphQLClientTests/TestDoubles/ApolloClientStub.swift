//
//  ApolloClientStub.swift
//  GraphQLClientTests
//
//  Created by Andrés Pesate on 01/01/2022.
//

import Apollo
import Foundation
import struct MockingHelpers.FunctionSpy

final class ApolloClientStub: ApolloClientProtocol {
  private(set) var fetchSpy = FunctionSpy<GraphQLQueryDummy, Void>()
  private(set) var clearCacheSpy = FunctionSpy<Void, Void>()
  var expectedResult: GraphQLQueryDummy.Data?
  var expectedCacheResultSource: Bool = false

  var store: ApolloStore = .init()
  var cacheKeyForObject: CacheKeyForObject?

  func clearCache(callbackQueue _: DispatchQueue, completion _: ((Result<Void, Error>) -> Void)?) {
    clearCacheSpy.call(parameters: nil)
  }

  func fetch<Query: GraphQLQuery>(
    query: Query,
    cachePolicy _: CachePolicy,
    contextIdentifier _: UUID?,
    queue _: DispatchQueue,
    resultHandler: GraphQLResultHandler<Query.Data>?
  ) -> Cancellable {
    fetchSpy.call(parameters: query as? GraphQLQueryDummy)
    let result: GraphQLResult<Query.Data> = GraphQLResult(
      data: expectedResult as? Query.Data,
      extensions: nil,
      errors: nil,
      source: expectedCacheResultSource ? .cache : .server,
      dependentKeys: nil
    )
    resultHandler?(.success(result))

    return EmptyCancellable()
  }

  func watch<Query>(
    query _: Query,
    cachePolicy _: CachePolicy,
    callbackQueue _: DispatchQueue,
    resultHandler _: @escaping GraphQLResultHandler<Query.Data>
  ) -> GraphQLQueryWatcher<Query> where Query: GraphQLQuery {
    fatalError("Missing Implementation")
  }

  func perform<Mutation>(
    mutation _: Mutation,
    publishResultToStore _: Bool,
    queue _: DispatchQueue,
    resultHandler _: GraphQLResultHandler<Mutation.Data>?
  ) -> Cancellable where Mutation: GraphQLMutation {
    fatalError("Missing Implementation")
  }

  func upload<Operation>(
    operation _: Operation,
    files _: [GraphQLFile],
    queue _: DispatchQueue,
    resultHandler _: GraphQLResultHandler<Operation.Data>?
  ) -> Cancellable where Operation: GraphQLOperation {
    fatalError("Missing Implementation")
  }

  func subscribe<Subscription>(
    subscription _: Subscription,
    queue _: DispatchQueue,
    resultHandler _: @escaping GraphQLResultHandler<Subscription.Data>
  ) -> Cancellable where Subscription: GraphQLSubscription {
    fatalError("Missing Implementation")
  }
}
