//
//  ProfileSummary.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 30/12/2021.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly. https://app.quicktype.io

import Foundation

// MARK: - ProfileSummary

struct ProfileSummary: Codable, Equatable {
  let user: User

  // MARK: - User

  struct User: Codable, Equatable {
    let avatarStringUrl: String
    let name: String
    let username: String
    let email: String?
    let followers: Follow
    let following: Follow
    let pinnedItems: Repositories?
    let topRepositories: Repositories?
    let starredRepositories: Repositories?

    enum CodingKeys: String, CodingKey {
      case avatarStringUrl = "avatarUrl"
      case name
      case username = "login"
      case email
      case followers
      case following
      case pinnedItems
      case topRepositories
      case starredRepositories
    }

    // MARK: Convenience

    var avatarUrl: URL? {
      URL(string: avatarStringUrl)
    }
  }

  // MARK: - Follow

  struct Follow: Codable, Equatable {
    let totalCount: Int
  }

  // MARK: - Repositories

  struct Repositories: Codable, Equatable {
    let nodes: [Repository]
  }

  // MARK: - Repository

  struct Repository: Codable, Equatable {
    let owner: Owner
    let title: String
    let description: String?
    let starsCount: Int
    let languages: Languages

    enum CodingKeys: String, CodingKey {
      case owner
      case title = "name"
      case description
      case starsCount = "stargazerCount"
      case languages
    }
  }

  // MARK: - Languages

  struct Languages: Codable, Equatable {
    let nodes: [Language]

    // MARK: Convenience

    var mainLanguage: String? {
      nodes.first?.name
    }

    var mainLanguageColor: String? {
      nodes.first?.color
    }
  }

  // MARK: - LanguagesNode

  struct Language: Codable, Equatable {
    let name: String
    let color: String
  }

  // MARK: - Owner

  struct Owner: Codable, Equatable {
    let username: String
    let avatarStringUrl: String

    enum CodingKeys: String, CodingKey {
      case username = "login"
      case avatarStringUrl = "avatarUrl"
    }

    // MARK: Convenience

    var avatarUrl: URL? {
      URL(string: avatarStringUrl)
    }
  }
}
