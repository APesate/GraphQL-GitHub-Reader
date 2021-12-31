//
//  CachePoliceProtocol.swift
//   GraphQLClient
//
//  Created by Andrés Pesate on 31/12/2021.
//

public protocol CachePoliceProtocol {
  var isCacheValid: Bool { get }

  func didUpdateCache()
}
