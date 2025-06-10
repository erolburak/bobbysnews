// swift-tools-version: 6.2

import PackageDescription

let package = Package(
    name: "BobbysNewsData",
    platforms: [
        .iOS(
            .v26,
        ),
    ],
    products: [
        .library(
            name: "BobbysNewsData",
            targets: [
                "BobbysNewsData",
            ],
        ),
    ],
    targets: [
        .target(
            name: "BobbysNewsData",
        ),
        .testTarget(
            name: "BobbysNewsDataTests",
            dependencies: [
                "BobbysNewsData",
            ],
        ),
    ],
)
