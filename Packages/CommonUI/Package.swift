// swift-tools-version:5.5

import PackageDescription

let package = Package(
  name: "CommonUI",
  platforms: [.iOS(.v13)],
  products: [
    .library(
      name: "CommonUI",
      targets: ["CommonUI"]
    ),
  ],
  targets: [
    .target(
      name: "CommonUI",
      dependencies: []
    ),
  ]
)
