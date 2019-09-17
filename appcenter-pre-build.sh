#!/usr/bin/env bash

INFO_PLIST=$APPCENTER_SOURCE_DIRECTORY/ios/$APPCENTER_XCODE_SCHEME/Info.plist
if [[ -e "$INFO_PLIST" ]]; then
    echo "Stripping unwanted MendixNative (i386, x86_64) archs"
    LIB_PATH=./ios/MendixNative/libMendix.a
    lipo -remove x86_64 -output $LIB_PATH $LIB_PATH
    lipo -remove i386 -output $LIB_PATH $LIB_PATH
    lipo -info $LIB_PATH

    echo "Updating Info.plist with code push key"
    plutil -replace "CodePushKey" -string $CODE_PUSH_KEY $INFO_PLIST

    cat $INFO_PLIST
fi

CODE_PUSH_KEY_FILE=$APPCENTER_SOURCE_DIRECTORY/android/app/src/main/res/raw/code_push_key
if [[ -e "$CODE_PUSH_KEY_FILE" ]]; then
    echo "Updating Android code_push_key resource file with code push key"
    sed -i '' 's/.*/'$CODE_PUSH_KEY'/' $CODE_PUSH_KEY_FILE;

    cat $CODE_PUSH_KEY_FILE
fi
