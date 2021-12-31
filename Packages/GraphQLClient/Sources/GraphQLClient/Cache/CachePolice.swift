//
//  CachePolice.swift
//
//
//  Created by Andrés Pesate on 31/12/2021.
//

import Foundation

struct CachePolice: CachePoliceProtocol {
  private static let CacheUpdatedAtKey = "CacheUpdatedAtKey"

  let cachePolicy: CachePolicy
  private let userDefaults: UserDefaultsProtocol

  init(cachePolicy: CachePolicy, userDefaults: UserDefaultsProtocol) {
    self.cachePolicy = cachePolicy
    self.userDefaults = userDefaults
  }

  // MARK: - Interface

  var isCacheValid: Bool {
    Date().timeIntervalSince1970 < cacheUpdatedAt + cachePolicy.limit
  }

  func didUpdateCache() {
    userDefaults.write(Date().timeIntervalSince1970, key: Self.CacheUpdatedAtKey)
  }

  // MARK: - Private

  private var cacheUpdatedAt: TimeInterval {
    let time: TimeInterval? = userDefaults.read(key: Self.CacheUpdatedAtKey)
    return time ?? 0
  }
}
