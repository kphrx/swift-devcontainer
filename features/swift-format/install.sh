#!/bin/bash

SWIFT_FORMAT_BRANCH="${BRANCHNAME:-"auto"}"

eval "$(swift --version | awk '/Swift/{print $3}' | sed 's/^\([0-9]\+\)\.\([0-9]\+\)\(\.[0-9]\+\)\?\(-dev\)\?$/export SWIFT_MAJOR=\1\
export SWIFT_MINOR=\2/')"

if [ "$SWIFT_FORMAT_BRANCH" = "auto" ]; then
    if [ "$SWIFT_MAJOR" -eq 5 ] && [ "$SWIFT_MINOR" -lt 6 ]; then
        SWIFT_FORMAT_BRANCH="swift-$SWIFT_MAJOR.$SWIFT_MINOR-branch"
    else
        SWIFT_FORMAT_BRANCH="release/$SWIFT_MAJOR.$SWIFT_MINOR"
    fi
fi

cd /opt || exit 1
git clone -b "$SWIFT_FORMAT_BRANCH" https://github.com/apple/swift-format.git || exit 1
cd swift-format || exit 1

swift build -c release || exit 1

ln -s $(swift build --show-bin-path -c release) /usr/local/bin/swift-format || exit 1
