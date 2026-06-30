// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WWHUDUI",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "WWHUDUI", targets: ["WWHUDUI"]),
    ],
    targets: [
        .target(name: "WWHUDUI", resources: [.copy("Privacy")]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
