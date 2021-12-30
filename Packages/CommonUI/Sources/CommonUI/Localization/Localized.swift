//
//  Localized.swift
//  CommonUI
//
//  Created by Andrés Pesate on 29/12/2021.
//

import Foundation

@propertyWrapper
public struct Localized {
  var value: String = ""

  public init(wrappedValue value: String) {
    wrappedValue = value
  }

  public var wrappedValue: String {
    get { value }
    set { value = newValue.localized }
  }
}
