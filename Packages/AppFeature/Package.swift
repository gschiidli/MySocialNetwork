// swift-tools-version: 6.2

import PackageDescription

let package = Package(
  name: "AppFeature",
  platforms: [
    .iOS(.v26),
    .macOS(.v26),
  ],
  products: [
    .library(name: "AppFeature", targets: ["AppFeature"])
  ],
  dependencies: [
    .package(path: "../ContactsClient"),
    .package(path: "../ContactDetailFeature"),
    .package(path: "../Models"),
    .package(
      url: "https://github.com/pointfreeco/swift-composable-architecture",
      from: "1.23.0"
    ),
    .package(
      url: "https://github.com/pointfreeco/sqlite-data",
      from: "1.3.0"
    ),
  ],
  targets: [
    .target(
      name: "AppFeature",
      dependencies: [
        "ContactsClient",
        "ContactDetailFeature",
        "Models",
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "SQLiteData", package: "sqlite-data"),
      ]
    )
  ]
)
