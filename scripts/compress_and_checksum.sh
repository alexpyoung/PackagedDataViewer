#!/usr/bin/env bash

if [ -z "$TRAVIS_TAG" ]; then
    exit 0
fi
cd ../.build/release
TARBALL_FILENAME="PackagedDataViewer-$TRAVIS_TAG.tar.gz"
CHECKSUMS_FILENAME="PackagedDataViewer-$TRAVIS_TAG-checksums.txt"
tar -czf $TARBALL_FILENAME PackagedDataViewer
CHECKSUM=$(shasum -a 256 $TARBALL_FILENAME | awk '{printf $1}')
rm -f $CHECKSUMS_FILENAME
touch $CHECKSUMS_FILENAME
echo $CHECKSUM >> $CHECKSUMS_FILENAME
echo $TARBALL_FILENAME >> $CHECKSUMS_FILENAME
