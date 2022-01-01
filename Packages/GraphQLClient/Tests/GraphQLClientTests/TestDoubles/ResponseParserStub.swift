//
//  ResponseParserStub.swift
//  GraphQLClientTests
//
//  Created by Andrés Pesate on 01/01/2022.
//

import protocol Apollo.GraphQLSelectionSet
import Foundation
import enum GraphQLClient.GraphQLClientError
import protocol GraphQLClient.ResponseParserProtocol
import struct MockingHelpers.FunctionSpy

class ResponseParserStub: ResponseParserProtocol {
  struct DummyResponse: Codable {
    private(set) var id = UUID()
  }


  private(set) var parseSpy = FunctionSpy<GraphQLSelectionSet?, Void>()
  var expectedResult: DummyResponse?
  var expectedError: GraphQLClientError?

  func parse<
    Response: Codable
  >(result: GraphQLSelectionSet?) throws -> Response {
    parseSpy.call(parameters: result)

    if let expectedError = expectedError {
      throw expectedError
    } else if let expectedResult = expectedResult {
      return expectedResult as! Response
    } else {
      fatalError("Missing Stub Configuration")
    }
  }
}

