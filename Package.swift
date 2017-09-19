// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "PackagedDataViewer",
    dependencies: [
        .package(url: "https://github.com/kylef/Commander.git", .exact("0.6.0")),
        // FIXME: Use .upToMinor(from: "0.11.4") once released
        .package(url: "https://github.com/stephencelis/SQLite.swift.git", .branch("release")),
        // FIXME: Use 1.0.0-alpha.5
        .package(url: "https://github.com/alexpyoung/TextTable.git", .branch("master"))
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
