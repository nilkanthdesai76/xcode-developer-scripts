#!/usr/bin/env bash
# ==============================================================================
# Universal XCFramework Builder Script
# Combines device and simulator framework slices into a distributable .xcframework
# ==============================================================================

set -euo pipefail

SCHEME="${1:-}"
PROJECT="${2:-}"

if [ -z "$SCHEME" ]; then
    echo "Usage: $0 <SchemeName> [ProjectName.xcodeproj]"
    exit 1
fi

PROJECT_ARG=""
if [ -n "$PROJECT" ]; then
    PROJECT_ARG="-project $PROJECT"
fi

OUTPUT_DIR="./build/xcframework"
rm -rf "$OUTPUT_DIR"
mkdir -p "$OUTPUT_DIR"

echo "🔨 [1/3] Building device slice (iphoneos)..."
xcodebuild archive \
    $PROJECT_ARG \
    -scheme "$SCHEME" \
    -destination "generic/platform=iOS" \
    -archivePath "$OUTPUT_DIR/ios_device.xcarchive" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    -quiet

echo "🔨 [2/3] Building simulator slice (iphonesimulator)..."
xcodebuild archive \
    $PROJECT_ARG \
    -scheme "$SCHEME" \
    -destination "generic/platform=iOS Simulator" \
    -archivePath "$OUTPUT_DIR/ios_simulator.xcarchive" \
    SKIP_INSTALL=NO \
    BUILD_LIBRARY_FOR_DISTRIBUTION=YES \
    -quiet

echo "📦 [3/3] Creating universal XCFramework..."
xcodebuild -create-xcframework \
    -framework "$OUTPUT_DIR/ios_device.xcarchive/Products/Library/Frameworks/${SCHEME}.framework" \
    -framework "$OUTPUT_DIR/ios_simulator.xcarchive/Products/Library/Frameworks/${SCHEME}.framework" \
    -output "$OUTPUT_DIR/${SCHEME}.xcframework"

echo "✨ Successfully generated: $OUTPUT_DIR/${SCHEME}.xcframework"
