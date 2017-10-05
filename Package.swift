// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "PackagedDataViewer",
    dependencies: [
        .package(url: "https://github.com/kylef/Commander.git", .upToNextMinor(from: "0.6.0")),
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", .upToNextMinor(from: "0.11.4")),
        .package(url: "https://github.com/alexpyoung/TextTable.git", from: "1.0.0-alpha.5")
    ],
    targets: [
        .target(
            name: "PackagedDataViewer",
            dependencies: [
                "Commander",
                "SQLite",
                "TextTable"
            ]
        )
    ]
)
