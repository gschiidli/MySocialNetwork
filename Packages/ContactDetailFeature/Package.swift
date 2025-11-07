// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "ContactDetailFeature",
  platforms: [
    .iOS(.v26),
    .macOS(.v26),
  ],
  products: [
    .library(name: "ContactDetailFeature", targets: ["ContactDetailFeature"])
  ],
  dependencies: [
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      from: "1.23.0"
    ),
    .package(path: "../Models")
  ],
  targets: [
    .target(
      name: "ContactDetailFeature",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Models", package: "Models")
      ]
    )
  ]
)
