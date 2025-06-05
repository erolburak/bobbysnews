// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "BobbysNewsDomain",
    platforms: [
        .iOS(
            .v18,
        ),
    ],
    products: [
        .library(
            name: "BobbysNewsDomain",
            targets: [
                "BobbysNewsDomain",
            ],
        ),
    ],
    dependencies: [
        Package.Dependency.package(
            path: "../BobbysNewsData",
        ),
    ],
    targets: [
        .target(
            name: "BobbysNewsDomain",
            dependencies: [
                Target.Dependency.product(
                    name: "BobbysNewsData",
                    package: "BobbysNewsData",
                ),
            ],
        ),
        .testTarget(
            name: "BobbysNewsDomainTests",
            dependencies: [
                "BobbysNewsDomain",
                Target.Dependency.product(
                    name: "BobbysNewsData",
                    package: "BobbysNewsData",
                ),
            ],
        ),
    ],
)
