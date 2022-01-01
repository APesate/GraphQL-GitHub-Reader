//
//  GraphQLClientStub.swift
//  GHPViewerTests
//
//  Created by Andrés Pesate on 01/01/2022.
//

import protocol Apollo.GraphQLQuery
import protocol GraphQLClient.GraphQLClientProtocol
import MockingHelpers

final class GraphQLClientStub: GraphQLClientProtocol {
  private(set) var getSpy = FunctionSpy<Void, Void>()

  var expectedResponse: (Any & Codable)?
  var expectedError: Error?

  func get<Query: GraphQLQuery, Response: Codable>(
    query _: Query,
    completionHandler: @escaping (Result<Response, Error>) -> Void
  ) {
    getSpy.call(parameters: nil)

    if let expectedError = expectedError {
      completionHandler(.failure(expectedError))
    } else if let expectedResponse = expectedResponse {
      completionHandler(.success(expectedResponse as! Response))
    }
  }
}
