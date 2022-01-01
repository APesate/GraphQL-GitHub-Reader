//
//  ProfileSummaryRepositoryStub.swift
//  GHPViewerTests
//
//  Created by Andrés Pesate on 01/01/2022.
//

@testable import GHPViewer
import enum GraphQLClient.GraphQLClientError
import struct MockingHelpers.FunctionSpy

final class ProfileSummaryRepositoryStub: ProfileSummaryRepositoryProtocol {
  private(set) var fetchUserSpy = FunctionSpy<Void, Void>()

  var expectedResponse: ProfileSummary?
  var expectedError: GraphQLClientError?

  func fetch(user _: String, completionHandler: @escaping (Response) -> Void) {
    fetchUserSpy.call(parameters: nil)

    if let expectedError = expectedError {
      completionHandler(.failure(expectedError))
    } else if let expectedResponse = expectedResponse {
      completionHandler(.success(expectedResponse))
    }
  }
}
