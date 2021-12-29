//
//  GraphQLClientProtocol.swift
//  GraphQLClient
//
//  Created by Andrés Pesate on 29/12/2021.
//

import protocol Apollo.GraphQLQuery

public protocol GraphQLClientProtocol {
  func get<Query: GraphQLQuery, Response: Decodable>(
    query: Query,
    completionHandler: @escaping (Result<Response?, Error>) -> Void
  )
}
