#!/bin/bash

SWIFT_FORMAT_BRANCH="${BRANCHNAME:-"auto"}"
PATCH_FILE_0001="$(realpath "$(dirname $0)/0001-use-fork.patch")"

eval "$(swift --version | awk '/Swift/{print $3}' | sed 's/^\([0-9]\+\)\.\([0-9]\+\)\(\.[0-9]\+\)\?\(-dev\)\?$/export SWIFT_MAJOR=\1\
export SWIFT_MINOR=\2/')"

if [ "$SWIFT_FORMAT_BRANCH" = "auto" ]; then
    if [ "$SWIFT_MAJOR" -eq 5 ] && [ "$SWIFT_MINOR" -lt 6 ]; then
        SWIFT_FORMAT_BRANCH="swift-$SWIFT_MAJOR.$SWIFT_MINOR-branch"
    else
        SWIFT_FORMAT_BRANCH="release/$SWIFT_MAJOR.$SWIFT_MINOR"
    fi
fi

git clone -b "$SWIFT_FORMAT_BRANCH" https://github.com/swiftlang/swift-format.git /opt/swift-format || exit 1
cd /opt/swift-format || exit 1

if [ "$SWIFT_MAJOR" -eq 5 ] && [ "$SWIFT_MINOR" -eq 8 ]; then
    git apply --reject "$PATCH_FILE_0001"
fi

swift build -c release || exit 1

ln -s $(swift build --show-bin-path -c release) /usr/local/bin/swift-format || exit 1
