// swift-tools-version: 5.5

// swiftlint:disable explicit_acl
// swiftlint:disable explicit_top_level_acl

import PackageDescription

let package = Package(
  name: "Base32Crockford",
  products: [
    .library(
      name: "Base32Crockford",
      targets: ["Base32Crockford"]
    )
  ],
  dependencies: [
  ],
  targets: [
    .target(
      name: "Base32Crockford",
      dependencies: []
    ),
    .testTarget(
      name: "Base32CrockfordTests",
      dependencies: ["Base32Crockford"]
    )
  ]
)
