//
//  UserDefaults.swift
//  GraphQLClientTests
//
//  Created by Andrés Pesate on 01/01/2022.
//

import protocol GraphQLClient.UserDefaultsProtocol
import struct MockingHelpers.FunctionSpy

final class UserDefaultsStub<Value>: UserDefaultsProtocol {
  private(set) var writeSpy = FunctionSpy<String, Void>()
  private(set) var readSpy = FunctionSpy<String, Void>()

  var expectedValue: Value?

  func write<T>(_ value: T, key: String) {
    writeSpy.call(parameters: key)
  }

  func read<T>(key: String) -> T? {
    readSpy.call(parameters: key)
    return expectedValue as? T
  }
}
