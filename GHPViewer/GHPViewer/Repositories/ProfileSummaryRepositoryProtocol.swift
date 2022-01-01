//
//  ProfileSummaryRepositoryProtocol.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 01/01/2022.
//

protocol ProfileSummaryRepositoryProtocol {
  typealias Response = Result<ProfileSummary, Error>

  func fetch(user username: String, completionHandler: @escaping (Response) -> Void)
}

