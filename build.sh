#!/bin/bash

if [[ ! -d "$ANDROID_NDK" ]];then
    echo 'env ANDROID_NDK not found'

    exit 1
fi

cd "$(dirname "$0")" || exit 1

BUILD_DIR=./build

mkdir -p "$BUILD_DIR"
cp "./src/module.prop" "$BUILD_DIR/module.prop"
cp "./src/customize.sh" "$BUILD_DIR/customize.sh"

mkdir -p "$BUILD_DIR/system/bin"
"$ANDROID_NDK/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android21-clang" "./src/stub.c" -o "$BUILD_DIR/system/bin/subsystem_ramdump_system"

mkdir -p "$BUILD_DIR/META-INF/com/google/android"
curl -L "https://raw.githubusercontent.com/topjohnwu/Magisk/master/scripts/module_installer.sh" > "$BUILD_DIR/META-INF/com/google/android/update-binary"
echo "#MAGISK" > "$BUILD_DIR/META-INF/com/google/android/updater-script"

cd "$BUILD_DIR" && zip -r ../module.zip '.'