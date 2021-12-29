//
//  Service.swift
//  GraphQLClient
//
//  Created by Andrés Pesate on 29/12/2021.
//

import struct Foundation.URL

public protocol Service {
  var url: URL { get }
  var additionalHeaders: [String: String]? { get }
}
