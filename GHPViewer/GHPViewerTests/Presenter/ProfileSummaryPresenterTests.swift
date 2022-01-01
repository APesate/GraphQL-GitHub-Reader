//
//  ProfileSummaryPresenterTests.swift
//  GHPViewerTests
//
//  Created by Andrés Pesate on 01/01/2022.
//

@testable import GHPViewer
import enum GraphQLClient.GraphQLClientError
import XCTest

class ProfileSummaryPresenterTests: XCTestCase {
  private var view: ProfileSummaryViewStub!
  private var repository: ProfileSummaryRepositoryStub!
  private var sut: ProfileSummaryPresenter!

  override func setUp() {
    super.setUp()

    view = ProfileSummaryViewStub()
    repository = ProfileSummaryRepositoryStub()
    sut = ProfileSummaryPresenter(profileSummaryRepository: repository)
    sut.view = view
  }

  func testFetchesDataOnViewDidLoad() {
    // When
    sut.viewDidLoad()

    // Then
    XCTAssertTrue(repository.fetchUserSpy.wasCalled)
  }

  func testFetchesDataOnReloadData() {
    // When
    sut.reloadData()

    // Then
    XCTAssertTrue(repository.fetchUserSpy.wasCalled)
  }

  func testInformsViewOfCorrectLoadingStatesOnViewDidLoad() {
    // Given
    let expectedViewLoadingStatesCalls = [true, false]
    let expectedResponse = dummyProfile()
    repository.expectedResponse = expectedResponse

    // When
    sut.viewDidLoad()

    // Then
    XCTAssertTrue(repository.fetchUserSpy.wasCalled)
    XCTAssertEqual(view.isLoadingSpy.numberOfCalls, 2)
    XCTAssertEqual(view.isLoadingSpy.calls, expectedViewLoadingStatesCalls)
  }

  func testInformsViewOfCorrectLoadingStatesOnReloadData() {
    // Given
    let expectedViewLoadingStatesCalls = [true, false]
    let expectedResponse = dummyProfile()
    repository.expectedResponse = expectedResponse

    // When
    sut.reloadData()

    // Then
    XCTAssertTrue(repository.fetchUserSpy.wasCalled)
    XCTAssertEqual(view.isLoadingSpy.numberOfCalls, 2)
    XCTAssertEqual(view.isLoadingSpy.calls, expectedViewLoadingStatesCalls)
  }

  func testInformsViewAfterSuccessfulDataLoad() {
    let expectedResponse = dummyProfile()
    repository.expectedResponse = expectedResponse

    // When
    sut.viewDidLoad()

    // Then
    XCTAssertTrue(repository.fetchUserSpy.wasCalled)
    XCTAssertTrue(view.didLoadDataSpy.wasCalled)
    XCTAssertFalse(view.didFailWithSpy.wasCalled)
    XCTAssertEqual(view.didLoadDataSpy.calls.first, expectedResponse)
    XCTAssertEqual(sut.profileSummary, expectedResponse)
  }

  func testInformsViewAfterGenericErrorLoadingData() {
    let responseError = GraphQLClientError.noData
    let expectedError = ProfileSummaryViewError.accountNotFound
    repository.expectedError = responseError

    // When
    sut.viewDidLoad()

    // Then
    XCTAssertTrue(repository.fetchUserSpy.wasCalled)
    XCTAssertFalse(view.didLoadDataSpy.wasCalled)
    XCTAssertTrue(view.didFailWithSpy.wasCalled)
    XCTAssertEqual(view.didFailWithSpy.calls.first, expectedError)
  }

  func testInformsViewIfTheAccountCouldNotBeFound() {
    let responseError = GraphQLClientError.serviceError
    let expectedError = ProfileSummaryViewError.somethingWentWrong
    repository.expectedError = responseError

    // When
    sut.viewDidLoad()

    // Then
    XCTAssertTrue(repository.fetchUserSpy.wasCalled)
    XCTAssertFalse(view.didLoadDataSpy.wasCalled)
    XCTAssertTrue(view.didFailWithSpy.wasCalled)
    XCTAssertEqual(view.didFailWithSpy.calls.first, expectedError)
  }
}

private extension ProfileSummaryPresenterTests {
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
