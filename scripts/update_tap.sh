#!/usr/bin/env bash

write_formula() {
    local -r TAG=$1
    local -r TARBALL_FILENAME=$2
    local -r CHECKSUM=$3
    local -r FILENAME='packageddataviewer.rb'
    local -r REPO_URL='https://github.com/alexpyoung/PackagedDataViewer'

    declare -a STRINGS=(
        'class Packageddataviewer < Formula'
        '  desc "A CLI for SQLite querying"'
        "  homepage $REPO_URL"
        "  url $REPO_URL/releases/download/$TAG/$TARBALL_FILENAME"
        "  sha256 $CHECKSUM"
        "  version $TAG"
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
       echo $i >> $FILENAME
    done
}

push_git() {
    local -r TAG=$1
    local -r TOKEN=$2
    git config --global user.email 'travis@travis-ci.org'
    git config --global user.name 'Travis CI'
    git commit -am "feat(packageddataviewer): $TAG"
    git remote add origin-ci https://$TOKEN@github.com/alexpyoung/homebrew-tools.git
    git push origin-ci master
}

main() {
    if [ $# -lt 3 ]; then
        echo 'Cannot continue without a token, tag, tarball filename, & checksum'
        exit 2
    fi
    local -r TOKEN=$1
    local -r TAG=$2
    local -r TARBALL_FILENAME=$3
    local -r CHECKSUM=$4

    git clone git://github.com/alexpyoung/homebrew-tools.git
    cd homebrew-tools/Formula

    write_formula $TAG $TARBALL_FILENAME $CHECKSUM
    push_git $TAG $TOKEN
}

main $1 $2 $3 $4
