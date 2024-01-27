// swift-tools-version: 5.9

import PackageDescription

let package = Package(name: "BobbysNewsData",
					  platforms: [.iOS(.v17)],
					  products: [.library(name: "BobbysNewsData",
										  targets: ["BobbysNewsData"])],
					  targets: [.target(name: "BobbysNewsData"),
								.testTarget(name: "BobbysNewsDataTests",
											dependencies: ["BobbysNewsData"])])
