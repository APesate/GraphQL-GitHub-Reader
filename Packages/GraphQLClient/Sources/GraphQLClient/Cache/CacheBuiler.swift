//
//  CacheBuilder.swift
//  GraphQLClient
//
//  Created by Andrés Pesate on 31/12/2021.
//

import class Apollo.InMemoryNormalizedCache
import protocol Apollo.NormalizedCache
import ApolloSQLite
import Foundation

struct CacheBuilder {
  private static let dbName = "graphql_db.sqlite"

  private var dbFileUrl: URL {
    let documentsPath = NSSearchPathForDirectoriesInDomains(
      .documentDirectory,
      .userDomainMask,
      true
    ).first!
    let documentsURL = URL(fileURLWithPath: documentsPath)
    return documentsURL.appendingPathComponent(Self.dbName)
  }

  func build() -> NormalizedCache {
    var cache: NormalizedCache
    if let sqlCache = try? SQLiteNormalizedCache(fileURL: dbFileUrl) {
      cache = sqlCache
    } else {
      cache = InMemoryNormalizedCache()
    }

    return cache
  }
}
