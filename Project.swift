import ProjectDescription

let project = Project(
  name: "MySocialNetwork",
  packages: [
    .package(path: "Packages/AppFeature"),
    .package(path: "Packages/ContactsClient"),
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
      name: "MySocialNetwork",
      destinations: [.iPhone, .iPad, .mac],
      product: .app,
      bundleId: "com.MySocialNetwork.app",
      infoPlist: .extendingDefault(
        with: [
          "UILaunchScreen": [
            "UIColorName": "",
            "UIImageName": "",
          ],
          "NSContactsUsageDescription":
            "This app needs access to your contacts to display them in a list.",
        ]
      ),
      buildableFolders: [
        "MySocialNetwork/Sources",
        "MySocialNetwork/Resources",
      ],
      dependencies: [
        .package(product: "AppFeature"),
        .package(product: "ContactsClientLive"),
        .package(product: "ComposableArchitecture"),
        .package(product: "SQLiteData"),
      ]
    ),
    .target(
      name: "MySocialNetworkTests",
      destinations: [.iPhone, .iPad, .mac],
      product: .unitTests,
      bundleId: "com.MySocialNetwork.app.tests",
      infoPlist: .default,
      buildableFolders: [
        "MySocialNetwork/Tests"
      ],
      dependencies: [.target(name: "MySocialNetwork")]
    ),
  ]
)
