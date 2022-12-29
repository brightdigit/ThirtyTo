// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Base32Crockford",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(
      name: "Base32Crockford",
      targets: ["Base32Crockford"]
    ),

    .executable(
      name: "base32dc",
      targets: ["base32dc"]
    )
  ],
  dependencies: [
    // Dev Dependencies for Formatting, Linting and Documentation
    .package(url: "https://github.com/shibapm/Komondor", from: "1.0.5"),
    .package(url: "https://github.com/eneko/SourceDocs", from: "1.2.1"),
    .package(url: "https://github.com/shibapm/Rocket", from: "0.1.0")
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "Base32Crockford",
      dependencies: []
    ),
    .target(
      name: "base32dc",
      dependencies: ["Base32Crockford"]
    ),
    .testTarget(
      name: "Base32CrockfordTests",
      dependencies: ["Base32Crockford"]
    )
  ]
)

#if canImport(PackageConfig)
  import PackageConfig

  let config = PackageConfiguration([
    "komondor": [
      "pre-push": "swift test --enable-code-coverage --enable-test-discovery",
      "pre-commit": [
        "swift test --enable-code-coverage --enable-test-discovery --generate-linuxmain",
        "swift run swiftformat .",
        "swift run swiftlint autocorrect",
        "swift run sourcedocs generate --spm-module Base32Crockford -c -r",
        // "swift run swiftpmls mine",
        "git add .",
        "swift run swiftformat --lint .",
        "swift run swiftlint"
      ]
    ]
  ]).write()
#endif
