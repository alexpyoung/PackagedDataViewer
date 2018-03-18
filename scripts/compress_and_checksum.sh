#!/usr/bin/env bash

if [ $# -lt 1 ]
  then
    echo 'Cannot continue without a tag'
    exit 2
fi
# Run from project root
cd .build/release
export TARBALL_FILENAME="PackagedDataViewer-$TAG.tar.gz"
export CHECKSUMS_FILENAME="PackagedDataViewer-$TAG-checksums.txt"
tar -czf $TARBALL_FILENAME PackagedDataViewer
export CHECKSUM=$(shasum -a 256 $TARBALL_FILENAME | awk '{printf $1}')
echo $CHECKSUM > $CHECKSUMS_FILENAME
echo $TARBALL_FILENAME >> $CHECKSUMS_FILENAME
