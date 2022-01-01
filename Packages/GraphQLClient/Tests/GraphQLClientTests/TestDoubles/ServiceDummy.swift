//
//  File.swift
//
//
//  Created by Andrés Pesate on 01/01/2022.
//

import Foundation
import protocol GraphQLClient.Service

struct ServiceDummy: Service {
  var url: URL
  var additionalHeaders: [String: String]?
}
