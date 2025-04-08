// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DatabaseKit",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DatabaseKit",
            targets: ["DatabaseKit"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/realm/realm-swift.git", from: "10.0.0")
        ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DatabaseKit",
            dependencies: [
              .product(name: "RealmSwift", package: "realm-swift")
            ]),
        .testTarget(
            name: "DatabaseKitTests",
            dependencies: ["DatabaseKit"]),
    ]
)
