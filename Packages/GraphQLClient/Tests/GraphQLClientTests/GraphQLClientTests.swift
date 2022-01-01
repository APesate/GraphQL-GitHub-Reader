//
//  File.swift
//
//
//  Created by Andrés Pesate on 29/12/2021.
//

import protocol Apollo.ApolloClientProtocol
@testable import GraphQLClient
import XCTest

final class GraphQLClientTests: XCTestCase {
  private static let DummyUrl = URL(string: "https://www.otrium.nl")!
  private static let DummyHeaders = ["Authorization": "SomeToken"]

  private var sut: GraphQLClient!
  private var service: ServiceDummy!
  private var client: ApolloClientStub!
  private var cachePolice: CachePoliceStub!
  private var responseParser: ResponseParserStub!

  override func setUp() {
    super.setUp()

    responseParser = ResponseParserStub()
    cachePolice = CachePoliceStub()
    client = ApolloClientStub()
    service = ServiceDummy(url: Self.DummyUrl, additionalHeaders: Self.DummyHeaders)
    sut = GraphQLClient(
      service: service,
      client: client,
      cachePolice: cachePolice,
      responseParser: responseParser
    )
  }

  func testSuccessfullyRetrievesData() {
    // Given
    let query = dummyQuery
    let clientExpectedResult = GraphQLQueryDummy.Data(unsafeResultMap: [:])
    let expectedResponse = ResponseParserStub.DummyResponse()
    let expectation = self
      .expectation(description: "Should execute `completionHandler` with a success")

    cachePolice.expectedCacheValidity = true
    responseParser.expectedResult = expectedResponse
    client.expectedResult = clientExpectedResult

    // When
    sut.get(query: query) { (result: Result<ResponseParserStub.DummyResponse, Error>) in
      switch result {
      case let .success(response):
        XCTAssertEqual(response.id, expectedResponse.id)
      case .failure:
        XCTFail("Shouldn't fail.")
      }
      expectation.fulfill()
    }

    // Then
    wait(for: [expectation], timeout: 1.0)
    XCTAssertTrue(client.fetchSpy.wasCalled)
    XCTAssertTrue(responseParser.parseSpy.wasCalled)
  }

  func testFailsToRetrieveData() {
    // Given
    let query = dummyQuery
    let clientExpectedResult = GraphQLQueryDummy.Data(unsafeResultMap: [:])
    let expectation = self
      .expectation(description: "Should execute `completionHandler` with a success")
    let expectedError = GraphQLClientError.failedToParseResponse

    cachePolice.expectedCacheValidity = true
    responseParser.expectedError = expectedError
    client.expectedResult = clientExpectedResult

    // When
    sut.get(query: query) { (result: Result<ResponseParserStub.DummyResponse, Error>) in
      switch result {
      case .success:
        XCTFail("Shouldn't succed")
      case let .failure(error):
        XCTAssertEqual(expectedError, error as? GraphQLClientError)
      }
      expectation.fulfill()
    }

    // Then
    wait(for: [expectation], timeout: 1.0)
    XCTAssertTrue(client.fetchSpy.wasCalled)
    XCTAssertTrue(responseParser.parseSpy.wasCalled)
  }

  func testFailsDueToNoData() {
    // Given
    let query = dummyQuery
    let expectation = self
      .expectation(description: "Should execute `completionHandler` with a success")
    let expectedError = GraphQLClientError.serviceError

    cachePolice.expectedCacheValidity = true
    responseParser.expectedError = expectedError
    client.expectedResult = nil

    // When
    sut.get(query: query) { (result: Result<ResponseParserStub.DummyResponse, Error>) in
      switch result {
      case .success:
        XCTFail("Shouldn't succed")
      case let .failure(error):
        XCTAssertEqual(expectedError, error as? GraphQLClientError)
      }
      expectation.fulfill()
    }

    // Then
    wait(for: [expectation], timeout: 1.0)
    XCTAssertTrue(client.fetchSpy.wasCalled)
    XCTAssertFalse(responseParser.parseSpy.wasCalled)
  }

  func testChecksValidityOfTheCache() {
    // Given
    let query = dummyQuery
    let expectedError = GraphQLClientError.serviceError

    cachePolice.expectedCacheValidity = true
    responseParser.expectedError = expectedError
    client.expectedResult = nil

    // When
    sut.get(query: query) { (_: Result<ResponseParserStub.DummyResponse, Error>) in
      // Nothing to check here
    }

    // Then
    XCTAssertTrue(cachePolice.isCacheValidSpy.wasCalled)
  }

  func testClearsCacheWhenNeeded() {
    // Given
    let query = dummyQuery
    let expectedError = GraphQLClientError.serviceError

    cachePolice.expectedCacheValidity = false
    responseParser.expectedError = expectedError
    client.expectedResult = nil

    // When
    sut.get(query: query) { (_: Result<ResponseParserStub.DummyResponse, Error>) in
      // Nothing to check here
    }

    // Then
    XCTAssertTrue(cachePolice.isCacheValidSpy.wasCalled)
    XCTAssertTrue(client.clearCacheSpy.wasCalled)
  }

  func testUpdatesCacheTimestampAfterServerRetrieval() {
    // Given
    let query = dummyQuery
    let clientExpectedResult = GraphQLQueryDummy.Data(unsafeResultMap: [:])
    let expectedResponse = ResponseParserStub.DummyResponse()
    let expectation = self
      .expectation(description: "Should execute `completionHandler` with a success")

    cachePolice.expectedCacheValidity = true
    responseParser.expectedResult = expectedResponse
    client.expectedResult = clientExpectedResult
    client.expectedCacheResultSource = false

    // When
    sut.get(query: query) { (_: Result<ResponseParserStub.DummyResponse, Error>) in
      expectation.fulfill()
    }

    // Then
    wait(for: [expectation], timeout: 1.0)
    XCTAssertTrue(client.fetchSpy.wasCalled)
    XCTAssertTrue(cachePolice.didUpdateCacheSpy.wasCalled)
  }

  func testDoesntUpdateCacheTimestampAfterCacheRetrieval() {
    // Given
    let query = dummyQuery
    let clientExpectedResult = GraphQLQueryDummy.Data(unsafeResultMap: [:])
    let expectedResponse = ResponseParserStub.DummyResponse()
    let expectation = self
      .expectation(description: "Should execute `completionHandler` with a success")

    cachePolice.expectedCacheValidity = true
    responseParser.expectedResult = expectedResponse
    client.expectedResult = clientExpectedResult
    client.expectedCacheResultSource = true

    // When
    sut.get(query: query) { (_: Result<ResponseParserStub.DummyResponse, Error>) in
      expectation.fulfill()
    }

    // Then
    wait(for: [expectation], timeout: 1.0)
    XCTAssertTrue(client.fetchSpy.wasCalled)
    XCTAssertFalse(cachePolice.didUpdateCacheSpy.wasCalled)
  }
}

private extension GraphQLClientTests {
  var dummyQuery: GraphQLQueryDummy {
    GraphQLQueryDummy()
  }
}
