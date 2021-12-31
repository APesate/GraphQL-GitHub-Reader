//
//  ProfileSummaryBuilder.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 30/12/2021.
//

import Foundation
import struct GraphQLClient.GraphQLClientBuilder
import protocol GraphQLClient.GraphQLClientProtocol

final class ProfileSummaryBuilder {
  // Format: Days * Hours * Minutes * Seconds
  private static let OneDayInSeconds: TimeInterval = 1 * 24 * 60 * 60

  func build() -> ProfileSummaryViewController {
    let presenter = self.presenter()
    let view = ProfileSummaryViewController(presenter: presenter)
    presenter.view = view

    return view
  }

  private func presenter() -> ProfileSummaryPresenterProtocol {
    ProfileSummaryPresenter(profileSummaryRepository: repository())
  }

  private func repository() -> ProfileSummaryRepositoryProtocol {
    ProfileSummaryRepository(client: client())
  }

  private func client() -> GraphQLClientProtocol {
    let service = GitHubService()
    return GraphQLClientBuilder()
      .client(
        for: service,
        // TODO: This value could be moved to a configuration file
        cachePolicy: .maxAge(seconds: Self.OneDayInSeconds)
      )
  }
}
