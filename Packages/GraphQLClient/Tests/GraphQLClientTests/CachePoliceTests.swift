//
//  CachePoliceTests.swift
//
//
//  Created by Andrés Pesate on 01/01/2022.
//

import Foundation
@testable import GraphQLClient
import XCTest

final class CachePoliceTests: XCTestCase {
  private static let CacheAgeInSeconds: TimeInterval = 5
  private lazy var cachePolicy = CachePolicy.maxAge(seconds: Self.CacheAgeInSeconds)
  private var userDefaults: UserDefaultsStub<TimeInterval>!
  private var sut: CachePolice!

  override func setUp() {
    super.setUp()

    userDefaults = UserDefaultsStub<TimeInterval>()
    sut = CachePolice(
      cachePolicy: cachePolicy,
      userDefaults: userDefaults
    )
  }

  func testCorrectlyChecksCacheValidity() {
    // Given
    let oldCacheUpdateTime = Date().timeIntervalSince1970 - 1000
    userDefaults.expectedValue = oldCacheUpdateTime

    // When
    let result = sut.isCacheValid

    // Then
    XCTAssertFalse(result)
    XCTAssertTrue(userDefaults.readSpy.wasCalled)
  }

  func testUpdatesCacheTimestamp() {
    // When
    sut.didUpdateCache()

    // Then
    XCTAssertTrue(userDefaults.writeSpy.wasCalled)
  }
}
