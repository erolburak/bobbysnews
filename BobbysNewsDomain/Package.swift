// swift-tools-version: 5.10

import PackageDescription

let package = Package(name: "BobbysNewsDomain",
					  platforms: [.iOS(.v17)],
					  products: [.library(name: "BobbysNewsDomain",
										  targets: ["BobbysNewsDomain"])],
					  dependencies: [.bobbysNewsData],
					  targets: [.target(name: "BobbysNewsDomain",
										dependencies: [.bobbysNewsData]),
								.testTarget(name: "BobbysNewsDomainTests",
											dependencies: ["BobbysNewsDomain",
														   .bobbysNewsData])])

private extension Package.Dependency {

	// MARK: - Properties

	static var bobbysNewsData = Package.Dependency.package(path: "../BobbysNewsData")
}

private extension Target.Dependency {

	// MARK: - Properties

	static var bobbysNewsData = Target.Dependency.product(name: "BobbysNewsData",
														  package: "BobbysNewsData")
}
