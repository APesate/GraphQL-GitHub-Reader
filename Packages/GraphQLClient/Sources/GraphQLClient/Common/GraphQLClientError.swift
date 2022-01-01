//
//  GraphQLClientError.swift
//  GraphQLClient
//
//  Created by Andrés Pesate on 31/12/2021.
//

public enum GraphQLClientError: Error, Equatable {
  case failedToParseResponse
  case serviceError
  case noData

  public static func == (lhs: Self, rhs: Self) -> Bool {
    switch (lhs, rhs) {
    case (Self.failedToParseResponse, Self.failedToParseResponse):
      return true
    case (Self.serviceError, Self.serviceError):
      return true
    case (Self.noData, Self.noData):
      return true
    default:
      return false
    }
  }
}
