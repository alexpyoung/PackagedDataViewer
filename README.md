# PackagedDataViewer

[![Build Status](https://travis-ci.org/alexpyoung/PackagedDataViewer.svg?branch=master)](https://travis-ci.org/alexpyoung/PackagedDataViewer) ![](https://img.shields.io/badge/swift-4.0-orange.svg)

A command line interface for browsing a gcios SQLite file

## Installation
```
brew install alexpyoung/tools/packageddataviewer
```

## Usage
- `packageddataviewer --help`
- `packageddataviewer events --help`

### Example
Listing sorted events from multiple files
```
packageddataviewer events <path-to-file-0> <path-to-file-n> --sort asc
```

## Building
- If necessary, install Swift 4 using `scripts/install.sh`
- `swift build -Xlinker -lsqlite3` (See [SQLite.swift](https://github.com/stephencelis/SQLite.swift/blob/master/Documentation/Index.md#swift-package-manager))
- The binary will be in `./.build/debug/PackagedDataViewer`
