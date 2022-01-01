// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "GraphQLClient",
  platforms: [
    .iOS(.v13),
  ],
  products: [
    .library(
      name: "GraphQLClient",
      targets: ["GraphQLClient"]
    ),
  ],
  dependencies: [
    .package(
      name: "Apollo",
      url: "https://github.com/apollographql/apollo-ios.git",
      from: Version("0.50.0")
    ),
    .package(name: "MockingHelpers", path: "./../MockingHelpers"),
  ],
  targets: [
    .target(
      name: "GraphQLClient",
      dependencies: [
        "Apollo",
        .product(name: "ApolloSQLite", package: "Apollo"),
      ]
    ),
    .testTarget(
      name: "GraphQLClientTests",
      dependencies: ["GraphQLClient", "MockingHelpers"]
    ),
  ]
)
