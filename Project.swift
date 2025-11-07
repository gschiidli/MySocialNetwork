import ProjectDescription

let project = Project(
    name: "MySocialNetwork",
    targets: [
        .target(
            name: "MySocialNetwork",
            destinations: .iOS,
            product: .app,
            bundleId: "com.MySocialNetwork.app",
            infoPlist: .extendingDefault(
                with: [
                    "UILaunchScreen": [
                        "UIColorName": "",
                        "UIImageName": "",
                    ],
                ]
            ),
            buildableFolders: [
                "MySocialNetwork/Sources",
                "MySocialNetwork/Resources",
            ],
            dependencies: []
        ),
        .target(
            name: "MySocialNetworkTests",
            destinations: .iOS,
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
