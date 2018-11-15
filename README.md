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

###### Listing teams sorted by name
```
packageddataviewer teams foo.db bar.db baz.db --sort-key name --sort-order asc
```

## Development
To get started, clone this repository and run `make`. If you would like to use Xcode, run `make xcode`.
