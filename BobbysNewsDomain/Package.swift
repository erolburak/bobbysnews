// swift-tools-version: 5.9

import PackageDescription

let package = Package(name: "BobbysNewsDomain",
					  platforms: [.iOS(.v17)],
					  products: [.library(name: "BobbysNewsDomain",
										  targets: ["BobbysNewsDomain"])],
					  dependencies: [.package(path: "../BobbysNewsData")],
					  targets: [.target(name: "BobbysNewsDomain",
										dependencies: [.product(name: "BobbysNewsData",
																package: "BobbysNewsData")]),
								.testTarget(name: "BobbysNewsDomainTests",
											dependencies: ["BobbysNewsDomain"])])
