#!/usr/bin/env bash

if [ $# -ge 3 ]
  then
    echo 'Cannot continue without a tag, tarball filename, & checksum'
    exit 0
fi

git clone git://github.com/alexpyoung/homebrew-tools.git
cd homebrew-tools/Formula

TAG=$1
TARBALL_FILENAME=$2
CHECKSUM=$3
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
git push origin master
