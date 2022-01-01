//
//  ResponseParserProtocol.swift
//  GraphQLClient
//
//  Created by Andrés Pesate on 01/01/2022.
//

import protocol Apollo.GraphQLSelectionSet

public protocol ResponseParserProtocol {
  func parse<
    Response: Codable
  >(result: GraphQLSelectionSet?) throws -> Response
}
