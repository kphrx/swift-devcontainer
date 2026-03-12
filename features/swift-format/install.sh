#!/bin/bash

if [ -z ${XDG_CONFIG_HOME+x} ]; then
    DOT_SWIFTPM="${HOME}/.swiftpm"
else
    DOT_SWIFTPM="${XDG_CONFIG_HOME}/swiftpm"
    ln -s "$DOT_SWIFTPM" "${HOME}/.swiftpm"
fi

BIN_PATH="${DOT_SWIFTPM}/bin"
mkdir -p "$BIN_PATH"

case ":${PATH}:" in
    *":${BIN_PATH}:"*)
        ;;
    *)
        PATH="${BIN_PATH}:${PATH}"
esac

SWIFT_FORMAT_FORCE_BUILD="${FORCEBUILD:-"false"}"
SWIFT_FORMAT_BRANCH="${BRANCHNAME:-"auto"}"

if [ "$SWIFT_FORMAT_FORCE_BUILD" = "false" ] && [ "$SWIFT_FORMAT_BRANCH" = "auto" ]; then
    swift format -h > /dev/null 2>&1 && echo "already installed swift-format" && exit 0 || echo "not installed swiftlang/swift-format"
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

echo "Installing swiftlang/swift-format:${SWIFT_FORMAT_BRANCH}"

PATCH_FILE_507="$(realpath "$(dirname $0)/507-use-fork-swift-argument-parser.patch")"
PATCH_FILE_508="$(realpath "$(dirname $0)/508-use-fork-swift-argument-parser.patch")"

git clone -b "$SWIFT_FORMAT_BRANCH" https://github.com/swiftlang/swift-format.git /opt/swift-format || echo "can't clone swiftlang/swift-format" && exit 1
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
    swift build --configuration=release || echo "failed build swiftlang/swift-format" && exit 1
    ln -s $(swift build --show-bin-path --configuration=release) "${BIN_PATH}/swift-format" || echo "failed install swiftlang/swift-format" && exit 1
else
    swift package experimental-install --product=swift-format || echo "failed build and install swiftlang/swift-format" && exit 1
fi
