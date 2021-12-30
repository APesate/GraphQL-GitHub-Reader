//
//  GitHubService.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 30/12/2021.
//

import Foundation
import protocol GraphQLClient.Service

struct GitHubService: Service {
  var url = URL(string: "https://api.github.com/graphql")!
  var additionalHeaders: [String: String]? =
    ["Authorization": "Bearer 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"]
}