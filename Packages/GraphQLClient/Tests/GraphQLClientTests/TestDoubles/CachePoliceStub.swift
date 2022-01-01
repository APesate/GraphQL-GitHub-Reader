//
//  File.swift
//  GraphQLCLientTests
//
//  Created by Andrés Pesate on 01/01/2022.
//

@testable import GraphQLClient
import struct MockingHelpers.FunctionSpy

final class CachePoliceStub: CachePoliceProtocol {
  private(set) var didUpdateCacheSpy = FunctionSpy<Void, Void>()
  private(set) var isCacheValidSpy = FunctionSpy<Void, Void>()

  var expectedCacheValidity: Bool?

  var isCacheValid: Bool {
    guard let expectedCacheValidity = expectedCacheValidity else {
      fatalError("Missing value")
    }

    isCacheValidSpy.call(parameters: nil)
    return expectedCacheValidity
  }

  func didUpdateCache() {
    didUpdateCacheSpy.call(parameters: nil)
  }
}
