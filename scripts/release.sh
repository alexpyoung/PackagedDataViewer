#!/usr/bin/env bash

# This script compresses/hashes an existing binary for homebrew distribution

main() {
    if [ $# -lt 1 ]; then
        echo 'Cannot continue without a version number'
    else
        local -r VERSION="$1"

        pushd "${0%/*}" || return 1
        TARBALL_FILENAME=$(./compress.sh "$VERSION")
        ./checksum.sh "$VERSION" "$TARBALL_FILENAME"
        popd || return 1
    fi
}

main "$1"
