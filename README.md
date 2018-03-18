# PackagedDataViewer

[![Build Status](https://travis-ci.org/alexpyoung/PackagedDataViewer.svg?branch=master)](https://travis-ci.org/alexpyoung/PackagedDataViewer) ![](https://img.shields.io/badge/swift-4.0-orange.svg)

A command line interface for browsing a gcios SQLite file

## Installation
```
brew install alexpyoung/tools/packageddataviewer
```

## Usage
- `packageddataviewer --help`
- `packageddataviewer <command> --help`

### Example
Listing teams sorted by name
```
packageddataviewer teams foo.db bar.db baz.db --sort-key name --sort-order asc
```

## Development
- `PackagedDataViewer` requires Swift `4.0.x`
    - If necessary, install Swift 4 using `scripts/install.sh`
### Sans Xcode
- `swift build`
- `./.build/debug/PackagedDataViewer --help`
### With Xcode
- `swift package generate-xcodeproj`
- `open PackagedDataViewer.xcodeproj`
