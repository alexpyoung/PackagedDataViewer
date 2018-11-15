#!/usr/bin/env bash

# This script updates the homebrew tap repository with a new release.
# The GitHub release must already exist prior to running this script.

write_formula() {
    local -r VERSION=$1
    local -r TARBALL_FILENAME=$2
    local -r CHECKSUM=$3
    local -r FILENAME='packageddataviewer.rb'
    local -r REPO_URL='https://github.com/alexpyoung/PackagedDataViewer'

    declare -a STRINGS=(
        'class Packageddataviewer < Formula'
        '  desc "A CLI for SQLite querying"'
        "  homepage $REPO_URL"
        "  url $REPO_URL/releases/download/$VERSION/$TARBALL_FILENAME"
        "  sha256 $CHECKSUM"
        "  version $VERSION"
        '  bottle :unneeded'
        '  def install'
        '    bin.install "packageddataviewer"'
        '  end'
        '  test do'
        '    system "#{bin}/packageddataviewer", "--version"'
        '  end'
        'end'
    )
    rm -f $FILENAME
    for i in "${STRINGS[@]}"; do
       echo "$i" >> $FILENAME
    done
}

push_git() {
    local -r VERSION=$1
    local -r TOKEN=$2
    git config --global user.email 'travis@travis-ci.org'
    git config --global user.name 'Travis CI'
    git commit -am "feat(packageddataviewer): $VERSION"
    git remote add origin-ci "https://$TOKEN@github.com/alexpyoung/homebrew-tools.git"
    git push origin-ci master
}

main() {
    if [ $# -lt 2 ]; then
        echo 'Cannot continue without a version number and token'
        return 2
    fi

    pushd "${0%/*}" || return 1

    local -r VERSION=$1
    local -r TOKEN=$2
    local -r TARBALL_FILENAME=$(./compress.sh "$VERSION")
    local -r CHECKSUM=$(./checksum.sh "$VERSION" "$TARBALL_FILENAME")

    git clone git://github.com/alexpyoung/homebrew-tools.git
    pushd homebrew-tools || return 1
    mkdir -p Formula && cd Formula || return 1
    write_formula "$VERSION" "$TARBALL_FILENAME" "$CHECKSUM"
    push_git "$VERSION" "$TOKEN"
    popd || return 1
    rm -rf homebrew-tools

    popd || return 1
}

main "$1" "$2"
