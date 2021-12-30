//
//  GraphQLClientProtocol.swift
//  GraphQLClient
//
//  Created by Andrés Pesate on 29/12/2021.
//

import protocol Apollo.GraphQLQuery
import struct Apollo.GraphQLResult

public protocol GraphQLClientProtocol {
  func get<Query: GraphQLQuery, Response: Codable>(
    query: Query,
    completionHandler: @escaping (Result<Response, Error>) -> Void
  )
}
