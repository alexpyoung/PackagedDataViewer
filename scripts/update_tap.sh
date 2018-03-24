#!/usr/bin/env bash

write-formula() {
    local -r TAG=$1
    local -r TARBALL_FILENAME=$2
    local -r CHECKSUM=$3
    local -r FILENAME='packageddataviewer.rb'
    local -r REPO_URL='https://github.com/alexpyoung/PackagedDataViewer'

    echo 'class Packageddataviewer < Formula' > $FILENAME
    echo '  desc "A CLI for SQLite querying"' >> $FILENAME
    echo "  homepage \"$REPO_URL\"" >> $FILENAME
    echo "  url \"$REPO_URL/releases/download/$TAG/$TARBALL_FILENAME\"" >> $FILENAME
    echo "  sha256 \"$CHECKSUM\"" >> $FILENAME
    echo "  version \"$TAG\"" >> $FILENAME
    echo '  bottle :unneeded' >> $FILENAME
    echo '  def install' >> $FILENAME
    echo '    bin.install "packageddataviewer"' >> $FILENAME
    echo '  end' >> $FILENAME
    echo '  test do' >> $FILENAME
    echo '    system "#{bin}/packageddataviewer", "--version"' >> $FILENAME
    echo '  end' >> $FILENAME
    echo 'end' >> $FILENAME
}

push-git() {
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

    write-formula $TAG $TARBALL_FILENAME $CHECKSUM
    push-git $TAG $TOKEN
}

main $1 $2 $3 $4
