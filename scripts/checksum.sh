#!/usr/bin/env bash

# This script hashes an existing, compressed binary for homebrew distribution
main() {
    local -r VERSION=$1
    local -r TARBALL_FILENAME=$2

    pushd "${0%/*}" > /dev/null || return 1
    cd ../.build/release || return 1
    CHECKSUMS_FILENAME="PackagedDataViewer-$VERSION-checksums.txt"
    CHECKSUM=$(shasum -a 256 "$TARBALL_FILENAME" | awk '{printf $1}')
    echo "$CHECKSUM" > "$CHECKSUMS_FILENAME"
    echo "$TARBALL_FILENAME" >> "$CHECKSUMS_FILENAME"
    popd > /dev/null || return 1

    echo "$CHECKSUM"
}

main "$1" "$2"
