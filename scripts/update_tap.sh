#!/usr/bin/env bash

if [ $# -lt 3 ]
  then
    echo 'Cannot continue without a token, tag, tarball filename, & checksum'
    exit 2
fi

git config --global user.email 'travis@travis-ci.org'
git config --global user.name 'Travis CI'
git clone git://github.com/alexpyoung/homebrew-tools.git
cd homebrew-tools/Formula

TOKEN=$1
TAG=$2
TARBALL_FILENAME=$3
CHECKSUM=$4
FILENAME="packageddataviewer.rb"
REPO_URL="https://github.com/alexpyoung/PackagedDataViewer"

echo "class Packageddataviewer < Formula" > $FILENAME
echo "  desc \"A CLI for SQLite querying\"" >> $FILENAME
echo "  homepage \"$REPO_URL\"" >> $FILENAME
echo "  url \"$REPO_URL/releases/download/$TAG/$TARBALL_FILENAME\"" >> $FILENAME
echo "  sha256 \"$CHECKSUM\"" >> $FILENAME
echo "  version \"$TAG\"" >> $FILENAME
echo "  bottle :unneeded" >> $FILENAME
echo "  def install" >> $FILENAME
echo "    bin.install \"packageddataviewer\"" >> $FILENAME
echo "  end" >> $FILENAME
echo "  test do" >> $FILENAME
echo "    system \"#{bin}/packageddataviewer\", \"--version\"" >> $FILENAME
echo "  end" >> $FILENAME
echo "end" >> $FILENAME

git commit -am "feat(packageddataviewer): $TAG"
git remote add origin-ci https://$TOKEN@github.com/alexpyoung/homebrew-tools.git
git push origin-ci master
