// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "MockingHelpers",
  products: [
    .library(name: "MockingHelpers", targets: ["MockingHelpers"]),
  ],
  targets: [
    .target(name: "MockingHelpers"),
  ]
)
