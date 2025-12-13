#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

# Get version from pubspec.yaml
VERSION=$(grep "^version:" pubspec.yaml | awk '{print $2}')

if [ -z "$VERSION" ]; then
  echo "Error: Could not extract version from pubspec.yaml"
  exit 1
fi

TAG="v$VERSION"
APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
OUTPUT_APK="delivery_app.apk"

echo "🚀 Preparing release $TAG..."

# Build APK
echo "📦 Building Release APK..."
flutter build apk --release

# Check if build was successful
if [ ! -f "$APK_PATH" ]; then
    echo "❌ Error: APK file not found at $APK_PATH"
    exit 1
fi

# Move APK
mv "$APK_PATH" "$OUTPUT_APK"
echo "✅ APK built and moved to $OUTPUT_APK"

# Create Release
echo "⬆️  Publishing release to GitHub..."
# Using --generate-notes to auto-fill notes from PRs/commits since last release
gh release create "$TAG" "$OUTPUT_APK" --title "Release $TAG" --generate-notes

echo "🎉 Release $TAG published successfully!"
echo "🔗 Permanent Download Link: https://github.com/SeragAmged/Delivery-app-ui-task/releases/latest/download/delivery_app.apk"
echo "🔗 Permanent Release Page: https://github.com/SeragAmged/Delivery-app-ui-task/releases/latest"
