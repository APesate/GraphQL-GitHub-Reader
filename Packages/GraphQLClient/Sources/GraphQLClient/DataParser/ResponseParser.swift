//
//  ResponseParser.swift
//  GraphQLClient
//
//  Created by Andrés Pesate on 01/01/2022.
//

import protocol Apollo.GraphQLSelectionSet
import Foundation

struct ResponseParser: ResponseParserProtocol {
  func parse<
    Response: Codable
  >(result: GraphQLSelectionSet?) throws -> Response {
    guard let result = result else {
      throw GraphQLClientError.noData
    }

    do {
      let jsonData = try JSONSerialization.data(
        withJSONObject: result.jsonObject,
        options: .fragmentsAllowed
      )
      return try JSONDecoder().decode(Response.self, from: jsonData)
    } catch {
      throw GraphQLClientError.failedToParseResponse
    }
  }
}
