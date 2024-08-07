// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MovieDetailsModule",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "MovieDetailsModule",
            targets: ["MovieDetailsModule"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.12.0"),
        .package(path: "../../MANetwork"),
        .package(path: "../../MoviesLookups"),
        .package(path: "../../Commons")
        ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "MovieDetailsModule",
            dependencies: [
              "Kingfisher",
              "MANetwork",
              "MoviesLookups",
              "Commons"
            ]),
        .testTarget(
          name: "MovieDetailsModuleTests",
          dependencies: ["MovieDetailsModule"],
          resources: [
            .copy("Resources/MockMovieDetailsNetworkResponse.json")
          ]
        )
    ]
)
