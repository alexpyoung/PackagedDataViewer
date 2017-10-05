# PackagedDataViewer

![](https://img.shields.io/badge/swift-4.0-orange.svg)

A command line interface for browsing a gcios SQLite file

## Building
- If necessary, [install `swiftenv`](https://swiftenv.fuller.li/en/latest/installation.html)
- If necessary, install Swift 4, `swiftenv install 4.0`
- `swift build -Xlinker -lsqlite3` (See [SQLite.swift](https://github.com/stephencelis/SQLite.swift/blob/master/Documentation/Index.md#swift-package-manager))

## Usage
- `.build/debug/PackagedDataViewer --help`
- `.build/debug/PackagedDataViewer events --help`

### Example
Listing sorted events from multiple files
```
.build/debug/PackagedDataViewer events <path-to-file-0> <path-to-file-n> --sort asc
```
