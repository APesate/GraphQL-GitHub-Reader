//
//  Profile.swift
//  GHPViewer
//
//  Created by Andrés Pesate on 29/12/2021.
//

import struct Foundation.URL

struct Profile {
  let avatarUrl: URL
  let name: String
  let username: String
  let followersCount: Int
  let followingCount: Int
  let email: String?
}
