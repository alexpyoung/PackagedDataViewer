import PackageDescription

let package = Package(
    name: "PackagedDataViewer",
    dependencies: [
        .Package(url: "https://github.com/kylef/Commander.git", Version(0,6,1)),
        .Package(url: "https://github.com/stephencelis/SQLite.swift.git", Version(0, 11, 3)),
        .Package(url: "https://github.com/alexpyoung/TextTable.git", Version(1, 0, 0, prereleaseIdentifiers: ["alpha", "5"]))
    ]
)
