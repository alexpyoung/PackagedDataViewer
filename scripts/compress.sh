#!/usr/bin/env bash

# This script compresses an existing binary for homebrew distribution
main() {
    local -r VERSION=$1

    pushd "${0%/*}" > /dev/null || return 1
    cd ../.build/release || return 1
    TARBALL_FILENAME="PackagedDataViewer-$VERSION.tar.gz"
    tar -czf "$TARBALL_FILENAME" packageddataviewer
    popd > /dev/null || return 1

    echo "$TARBALL_FILENAME"
}

main "$1"
