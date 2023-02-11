// swift-tools-version: 5.7

import PackageDescription

let package = Package(
    name: "RemoteData",
    platforms: [
        .macOS(.v11),
        .iOS(.v15),
        .tvOS(.v15),
        .watchOS(.v8)
    ],
    products: [
        .library(
            name: "RemoteData",
            targets: ["RemoteData"]
        ),
    ],
    targets: [
        .target(
            name: "RemoteData",
            dependencies: []
        ),
        .testTarget(
            name: "RemoteDataTests",
            dependencies: ["RemoteData"]
        ),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
