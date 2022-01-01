//
//  ProfileSummaryRepositoryTests.swift
//  GHPViewerTests
//
//  Created by Andrés Pesate on 01/01/2022.
//

@testable import GHPViewer
import enum GraphQLClient.GraphQLClientError
import XCTest

class ProfileSummaryRepositoryTests: XCTestCase {
  private static let ProfileUsername = "apesate"

  private var client: GraphQLClientStub!
  private var sut: ProfileSummaryRepository!

  override func setUp() {
    super.setUp()

    client = GraphQLClientStub()
    sut = ProfileSummaryRepository(client: client)
  }

  func testFetchesProfileSummarySuccessfully() {
    // Given
    let expectation = self.expectation(description: "Should call `completionHandler`")
    let expectedResponse = dummyProfile()
    client.expectedResponse = expectedResponse

    // When
    sut.fetch(
      user: Self.ProfileUsername
    ) { response in
      expectation.fulfill()

      switch response {
      case let .success(profile):
        XCTAssertEqual(profile, expectedResponse)
      case .failure:
        XCTFail("Shouldn't Fail")
      }
    }

    // Then
    wait(for: [expectation], timeout: 1.0)
    XCTAssertTrue(client.getSpy.wasCalled)
  }

  func testFailsToFetchProfileSummary() {
    // Given
    let expectation = self.expectation(description: "Should call `completionHandler`")
    let expectedError = GraphQLClientError.serviceError
    client.expectedError = expectedError

    // When
    sut.fetch(
      user: Self.ProfileUsername
    ) { response in
      expectation.fulfill()

      switch response {
      case .success:
        XCTFail("Shouldn't Succed")
      case let .failure(error):
        XCTAssertEqual(error as? GraphQLClientError, expectedError)
      }
    }

    // Then
    wait(for: [expectation], timeout: 1.0)
    XCTAssertTrue(client.getSpy.wasCalled)
  }
}

private extension ProfileSummaryRepositoryTests {
  private static let AvatarStringUrl = "SomeAvatarUrl"
  private static let Name = "SomeName"
  private static let Username = "SomeUsername"
  private static let Email = "Email"
  private static let Followers = ProfileSummary.Follow(totalCount: 5)
  private static let Following = ProfileSummary.Follow(totalCount: 5)

  func dummyProfile() -> ProfileSummary {
    ProfileSummary(
      user: ProfileSummary.User(
        avatarStringUrl: Self.AvatarStringUrl,
        name: Self.Name,
        username: Self.Username,
        email: Self.Email,
        followers: Self.Followers,
        following: Self.Following,
        pinnedItems: nil,
        topRepositories: nil,
        starredRepositories: nil
      )
    )
  }
}
