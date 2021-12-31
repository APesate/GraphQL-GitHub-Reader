//
//  GraphQLClientError.swift
//  GraphQLClient
//
//  Created by Andrés Pesate on 31/12/2021.
//

public enum GraphQLClientError: Error {
  case failedToParseResponse
  case serviceError
  case noData
}
