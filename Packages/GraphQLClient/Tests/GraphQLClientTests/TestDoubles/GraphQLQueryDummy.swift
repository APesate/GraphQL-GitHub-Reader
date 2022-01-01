//
//  GraphQLQueryDummy.swift
//  GraphQLClientTests
//
//  Created by Andrés Pesate on 01/01/2022.
//

import Apollo

final class GraphQLQueryDummy: GraphQLQuery {
  struct Data: GraphQLSelectionSet {
    static var selections: [GraphQLSelection] = []
    var resultMap: ResultMap

    init(unsafeResultMap: ResultMap) {
      resultMap = unsafeResultMap
    }
  }

  var operationType: GraphQLOperationType = .query
  var operationDefinition: String = ""
  var operationName: String = ""
  var queryDocument: String = ""
  var operationIdentifier: String?
  var variables: GraphQLMap?
}
