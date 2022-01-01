//
//  Spied.swift
//  MockingHelpers
//
//  Created by Andris Lejasmeiers on 04/10/2020.
//

@propertyWrapper
public struct Spied<T> {
  private var value: T

  public var projectedValue = [T]()

  public init(value: T) {
    self.value = value
  }

  public var wrappedValue: T {
    get { value }
    set {
      projectedValue.append(newValue)
      value = newValue
    }
  }
}
