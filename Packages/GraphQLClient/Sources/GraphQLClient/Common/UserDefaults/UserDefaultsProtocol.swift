//
//  UserDefaultsProtocol.swift
//  GraphQLClient
//
//  Created by Andrés Pesate on 31/12/2021.
//

import Foundation

public protocol UserDefaultsProtocol {
  func write<T: Any>(_ value: T, key: String)
  func read<T: Any>(key: String) -> T?
}

extension UserDefaults: UserDefaultsProtocol {
  public func write<T: Any>(_ value: T, key: String) {
    set(value, forKey: key)
  }

  public func read<T: Any>(key: String) -> T? {
    object(forKey: key) as? T
  }
}
