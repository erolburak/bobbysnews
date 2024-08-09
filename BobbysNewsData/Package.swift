// swift-tools-version: 6.0

import PackageDescription

let package = Package(name: "BobbysNewsData",
					  platforms: [.iOS(.v18)],
					  products: [.library(name: "BobbysNewsData",
										  targets: ["BobbysNewsData"])],
					  targets: [.target(name: "BobbysNewsData"),
								.testTarget(name: "BobbysNewsDataTests",
											dependencies: ["BobbysNewsData"])])
