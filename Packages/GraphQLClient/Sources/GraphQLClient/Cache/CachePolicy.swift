//
//  CachePolicy.swift
//  GraphQLClient
//
//  Created by Andrés Pesate on 31/12/2021.
//

import Foundation

public enum CachePolicy {
  case maxAge(seconds: TimeInterval)

  var limit: TimeInterval {
    switch self {
    case let .maxAge(seconds):
      return seconds
    }
  }
}
