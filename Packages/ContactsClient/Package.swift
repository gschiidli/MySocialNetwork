// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "ContactsClient",
  platforms: [
    .iOS(.v26),
    .macOS(.v26),
  ],
  products: [
    .library(name: "ContactsClient", targets: ["ContactsClient"]),
    .library(name: "ContactsClientLive", targets: ["ContactsClientLive"])
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
      name: "ContactsClient",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Models", package: "Models")
      ]
    ),
    .target(
      name: "ContactsClientLive",
      dependencies: [
        "ContactsClient",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Models", package: "Models")
      ]
    )
  ]
)
