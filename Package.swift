// swift-tools-version: 5.5

// swiftlint:disable explicit_acl
// swiftlint:disable explicit_top_level_acl

import PackageDescription

let package = Package(
  name: "ThirtyTo",
  products: [
    .library(
      name: "ThirtyTo",
      targets: ["ThirtyTo"]
    )
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "ThirtyTo",
      dependencies: []
    ),
    .testTarget(
      name: "ThirtyToTests",
      dependencies: ["ThirtyTo"]
    )
  ]
)
