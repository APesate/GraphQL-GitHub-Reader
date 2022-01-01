//
//  ProfileSummaryRepository.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 30/12/2021.
//

import protocol GraphQLClient.GraphQLClientProtocol

final class ProfileSummaryRepository: ProfileSummaryRepositoryProtocol {
  private let client: GraphQLClientProtocol

  init(client: GraphQLClientProtocol) {
    self.client = client
  }

  // MARK: - Interface

  func fetch(user username: String, completionHandler: @escaping (Response) -> Void) {
    let query = self.query(for: username)
    client
      .get(
        query: query,
        completionHandler: completionHandler
      )
  }

  // MARK: - Private

  private func query(for username: String) -> ProfileSummaryQuery {
    .init(username: username)
  }
}
