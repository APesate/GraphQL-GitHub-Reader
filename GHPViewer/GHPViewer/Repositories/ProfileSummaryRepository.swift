//
//  ProfileSummaryRepository.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 30/12/2021.
//

import Foundation
import protocol GraphQLClient.GraphQLClientProtocol

protocol ProfileSummaryRepositoryProtocol {
  typealias Response = Result<ProfileSummary, Error>

  func fetch(completionHandler: @escaping (Response) -> Void)
}

final class ProfileSummaryRepository: ProfileSummaryRepositoryProtocol {
  private let client: GraphQLClientProtocol

  init(client: GraphQLClientProtocol) {
    self.client = client
  }

  // MARK: - Interface

  func fetch(completionHandler: @escaping (Response) -> Void) {
    client
      .get(
        query: ProfileSummaryQuery(username: "apesate"),
        completionHandler: completionHandler
      )
  }
}
