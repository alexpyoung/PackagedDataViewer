#!/usr/bin/env bash

# This script ensures the necessary version of swift is installed for development

install_swiftenv() {
    if swiftenv -v; then
        return 0
    else
        git clone --depth 1 https://github.com/kylef/swiftenv.git ~/.swiftenv
        export SWIFTENV_ROOT="$HOME/.swiftenv"
        export PATH="$SWIFTENV_ROOT/bin:$SWIFTENV_ROOT/shims:$PATH"
    fi
}

install_swift() {
    if [ -f ".swift-version" ] || [ -n "$SWIFT_VERSION" ]; then
        swiftenv install -s
    else
        swiftenv rehash
    fi
}

main() {
    local -r VERSION=$(cat ./.swift-version)
    if [[ $(swift --version) =~ $VERSION ]]; then
        return 0
    else
        echo "Swift v$VERSION not found. Install from swiftenv"
        install_swiftenv && install_swift
    fi
}

main
