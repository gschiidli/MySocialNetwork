import ProjectDescription

let project = Project(
    name: "MySocialNetwork",
    targets: [
        .target(
            name: "MySocialNetwork",
            destinations: .iOS,
            product: .app,
            bundleId: "dev.tuist.MySocialNetwork",
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
            bundleId: "dev.tuist.MySocialNetworkTests",
            infoPlist: .default,
            buildableFolders: [
                "MySocialNetwork/Tests"
            ],
            dependencies: [.target(name: "MySocialNetwork")]
        ),
    ]
)
