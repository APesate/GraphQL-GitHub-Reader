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
    return GraphQLClientBuilder().client(for: service)
  }
}
