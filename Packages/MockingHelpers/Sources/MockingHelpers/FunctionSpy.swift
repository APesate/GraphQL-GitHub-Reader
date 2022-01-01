//
//  FunctionSpy.swift
//  MockingHelpers
//
//  Created by Popov Yuri on 30/09/2020.
//

public struct FunctionSpy<Input, Output> {
  public private(set) var calls = [Input?]()
  public private(set) var output: Output?

  public var wasCalled: Bool {
    numberOfCalls > 0
  }

  public var numberOfCalls: Int {
    calls.count
  }

  public init(output: Output? = nil) {
    self.output = output
  }

  public mutating func call(parameters: Input? = nil) -> Output? {
    calls.append(parameters)
    return output
  }
}
