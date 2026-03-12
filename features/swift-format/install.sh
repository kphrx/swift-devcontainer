#!/bin/bash

if [ -z ${XDG_CONFIG_HOME+x} ]; then
    BIN_PATH="${HOME}/.swiftpm/bin"
else
    BIN_PATH="${XDG_CONFIG_HOME}/swiftpm/bin"
fi

case ":${PATH}:" in
    *":${BIN_PATH}:"*)
        ;;
    *)
        PATH="${BIN_PATH}:${PATH}"
esac

SWIFT_FORMAT_FORCE_BUILD="${FORCEBUILD:-"false"}"
SWIFT_FORMAT_BRANCH="${BRANCHNAME:-"auto"}"

if [ "$SWIFT_FORMAT_BRANCH" = "false" ] && [ "$SWIFT_FORMAT_BRANCH" = "auto" ]; then
    swift format -h >/dev/null && exit 0
fi

eval "$(swift --version | awk '/Swift/{print $3}' | sed 's/^\([0-9]\+\)\.\([0-9]\+\)\(\.[0-9]\+\)\?\(-dev\)\?$/export SWIFT_MAJOR=\1\
export SWIFT_MINOR=\2/')"

if [ "$SWIFT_FORMAT_BRANCH" = "auto" ]; then
    if [ "$SWIFT_MAJOR" -eq 5 ] && [ "$SWIFT_MINOR" -lt 6 ]; then
        SWIFT_FORMAT_BRANCH="swift-$SWIFT_MAJOR.$SWIFT_MINOR-branch"
    else
        SWIFT_FORMAT_BRANCH="release/$SWIFT_MAJOR.$SWIFT_MINOR"
    fi
fi

PATCH_FILE_507="$(realpath "$(dirname $0)/507-use-fork-swift-argument-parser.patch")"
PATCH_FILE_508="$(realpath "$(dirname $0)/508-use-fork-swift-argument-parser.patch")"

git clone -b "$SWIFT_FORMAT_BRANCH" https://github.com/swiftlang/swift-format.git /opt/swift-format || exit 1
cd /opt/swift-format || exit 1

if [ "$SWIFT_MAJOR" -eq 5 ]; then
    if [ "$SWIFT_MINOR" -eq 7 ]; then
        git apply --reject "$PATCH_FILE_507"
    fi
    if [ "$SWIFT_MINOR" -eq 8 ]; then
        git apply --reject "$PATCH_FILE_508"
    fi
fi

if [ "$SWIFT_MAJOR" -eq 5 ] && [ "$SWIFT_MINOR" -lt 10 ]; then
    swift build --configuration=release || exit 1
    ln -s $(swift build --show-bin-path --configuration=release) "${BIN_PATH}/swift-format" || exit 1
else
    swift package experimental-install --product=swift-format || exit 1
fi
