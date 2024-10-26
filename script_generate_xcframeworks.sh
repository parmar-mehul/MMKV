#!/bin/bash

echo "start..."
echo "Generate XCFramework for MMKV & MMKVWatchExtension"

# Initialize variables
SCHEME_NAME="MMKV"
FRAMEWORK_NAME="MMKV"
OUTPUT_DIC="/Users/mehul/Documents/iOS/Projects/Library/XCFramework/MMKV/XCFramework"
FRAMEWORK_PATH="${OUTPUT_DIC}/${FRAMEWORK_NAME}.xcframework"
FRAMEWORK_PATH_ZIP="${FRAMEWORK_PATH}.zip"

FRAMEWORK_NAME_MMKVWatchExtension="MMKVWatchExtension"
FRAMEWORK_PATH_MMKVWatchExtension="${OUTPUT_DIC}/${FRAMEWORK_NAME_MMKVWatchExtension}.xcframework"
FRAMEWORK_PATH_ZIP_MMKVWatchExtension="${FRAMEWORK_PATH_MMKVWatchExtension}.zip"

# Clean up old output directory
#rm -rf ~/Library/Developer/Xcode/DerivedData/*
#rm -rf "${OUTPUT_DIC}" # Ensure output directory is fully cleared
#mkdir -p "${OUTPUT_DIC}"
#echo "Cleaned Derived Data and created output directory"

# Function to archive frameworks
archive_framework() {
	local scheme_name="$1"
	local sdk_name="$2"
	local archive_name="$3"
	local destination_name="$4"
	local archive_path="${OUTPUT_DIC}/${FRAMEWORK_NAME}-${archive_name}.xcarchive"

	# For macOS-Catalyst, no -destination for clean, but keep it for archive
	if [ "$archive_name" = "macOS-Catalyst" ]; then
		xcodebuild clean \
			-scheme "${scheme_name}" \
			-sdk "${sdk_name}" \
			-configuration Release

		xcodebuild archive \
			-scheme "${scheme_name}" \
			-archivePath "${archive_path}" \
			-destination "generic/platform=${destination_name}" \
			-configuration Release \
			SKIP_INSTALL=NO \
			BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcpretty
	else
		xcodebuild clean \
			-scheme "${scheme_name}" \
			-sdk "${sdk_name}" \
			-destination "generic/platform=${destination_name}" \
			-configuration Release

		xcodebuild archive \
			-scheme "${scheme_name}" \
			-sdk "${sdk_name}" \
			-archivePath "${archive_path}" \
			-destination "generic/platform=${destination_name}" \
			-configuration Release \
			SKIP_INSTALL=NO \
			BUILD_LIBRARY_FOR_DISTRIBUTION=YES | xcpretty
	fi
}

# Archive all frameworks
#archive_framework "${SCHEME_NAME}" iphoneos "iOS" "iOS"
#archive_framework "${SCHEME_NAME}" iphonesimulator "iOS-Simulator" "iOS Simulator"
#archive_framework "${SCHEME_NAME}" appletvos "tvOS" "tvOS"
#archive_framework "${SCHEME_NAME}" appletvsimulator "tvOS-Simulator" "tvOS Simulator"
#archive_framework "${SCHEME_NAME}" "macosx" "macOS-Catalyst" "macOS,variant=Mac Catalyst,name=Any Mac"
#archive_framework "${SCHEME_NAME}" "macosx" "macOS" "macOS"
#
#archive_framework "MMKVWatchExtension" watchos "watchOS" "watchOS"
#archive_framework "MMKVWatchExtension" watchsimulator "watchOS-Simulator" "watchOS Simulator"

find "${OUTPUT_DIC}" -name "*.framework" -or -name "*.dylib" | while read component; do
	codesign --timestamp -v --sign "Apple Distribution: Covantex LLC (8JPF68MSBL)" "$component"
	codesign --verify --deep --strict "$component"
	codesign -dv "$component"
done

# Create XCFramework combining all architectures, currently I am generating for
# ios-arm64, ios-arm64_x86_64-maccatalyst, ios-arm64_x86_64-simulator, ios-arm64_x86_64-maccatalyst
# macos-arm64_x86_64, macos-arm64_x86_64
# watchos-arm64_i386_x86_64-simulator, watchos-arm64_arm64_32_armv7k
# tvos-arm64, tvos-arm64_x86_64-simulator
xcodebuild -create-xcframework \
	-framework "${OUTPUT_DIC}/${FRAMEWORK_NAME}-iOS.xcarchive/Products/Library/Frameworks/${SCHEME_NAME}.framework" \
	-debug-symbols "${OUTPUT_DIC}/${FRAMEWORK_NAME}-iOS.xcarchive/dSYMs/${SCHEME_NAME}.framework.dSYM" \
	-framework "${OUTPUT_DIC}/${FRAMEWORK_NAME}-iOS-Simulator.xcarchive/Products/Library/Frameworks/${SCHEME_NAME}.framework" \
	-debug-symbols "${OUTPUT_DIC}/${FRAMEWORK_NAME}-iOS-Simulator.xcarchive/dSYMs/${SCHEME_NAME}.framework.dSYM" \
	-framework "${OUTPUT_DIC}/${FRAMEWORK_NAME}-tvOS-Simulator.xcarchive/Products/Library/Frameworks/${SCHEME_NAME}.framework" \
	-debug-symbols "${OUTPUT_DIC}/${FRAMEWORK_NAME}-tvOS-Simulator.xcarchive/dSYMs/${SCHEME_NAME}.framework.dSYM" \
	-framework "${OUTPUT_DIC}/${FRAMEWORK_NAME}-tvOS.xcarchive/Products/Library/Frameworks/${SCHEME_NAME}.framework" \
	-debug-symbols "${OUTPUT_DIC}/${FRAMEWORK_NAME}-tvOS.xcarchive/dSYMs/${SCHEME_NAME}.framework.dSYM" \
	-framework "${OUTPUT_DIC}/${FRAMEWORK_NAME}-macOS.xcarchive/Products/Library/Frameworks/${SCHEME_NAME}.framework" \
	-debug-symbols "${OUTPUT_DIC}/${FRAMEWORK_NAME}-macOS.xcarchive/dSYMs/${SCHEME_NAME}.framework.dSYM" \
	-framework "${OUTPUT_DIC}/${FRAMEWORK_NAME}-macOS-Catalyst.xcarchive/Products/Library/Frameworks/${SCHEME_NAME}.framework" \
	-debug-symbols "${OUTPUT_DIC}/${FRAMEWORK_NAME}-macOS-Catalyst.xcarchive/dSYMs/${SCHEME_NAME}.framework.dSYM" \
	-output "${FRAMEWORK_PATH}"

xcodebuild -create-xcframework \
	-framework "${OUTPUT_DIC}/${FRAMEWORK_NAME}-watchOS.xcarchive/Products/Library/Frameworks/MMKVWatchExtension.framework" \
	-debug-symbols "${OUTPUT_DIC}/${FRAMEWORK_NAME}-watchOS.xcarchive/dSYMs/MMKVWatchExtension.framework.dSYM" \
	-framework "${OUTPUT_DIC}/${FRAMEWORK_NAME}-watchOS-Simulator.xcarchive/Products/Library/Frameworks/MMKVWatchExtension.framework" \
	-debug-symbols "${OUTPUT_DIC}/${FRAMEWORK_NAME}-watchOS-Simulator.xcarchive/dSYMs/MMKVWatchExtension.framework.dSYM" \
	-output "${FRAMEWORK_PATH_MMKVWatchExtension}"

find "${FRAMEWORK_PATH}" -name "*.framework" -or -name "*.dylib" | while read component; do
	codesign --timestamp -v --sign "Apple Distribution: Covantex LLC (8JPF68MSBL)" "${component}"
	codesign --verify --deep --strict "${component}"
	codesign -dv "${component}"
	codesign -vv "${component}"
done

find "${FRAMEWORK_PATH_MMKVWatchExtension}" -name "*.framework" -or -name "*.dylib" | while read component; do
	codesign --timestamp -v --sign "Apple Distribution: Covantex LLC (8JPF68MSBL)" "${component}"
	codesign --verify --deep --strict "${component}"
	codesign -dv "${component}"
	codesign -vv "${component}"
done

# Zip the XCFramework
if [ -d "${FRAMEWORK_PATH}" ]; then
	# Sign the XCFramework
	codesign --timestamp -v --sign "Apple Distribution: Covantex LLC (8JPF68MSBL)" "${FRAMEWORK_PATH}"
	codesign --verify --deep --strict "${FRAMEWORK_PATH}"
	codesign -dv "${FRAMEWORK_PATH}"
	codesign -vv "${FRAMEWORK_PATH}"

	# Zip the XCFramework & Preserve symlinks using the -y option
	cd "${OUTPUT_DIC}" && zip -ryqo "${FRAMEWORK_PATH_ZIP}" "${FRAMEWORK_PATH}"

	# Compute and write checksum
	swift package compute-checksum "${FRAMEWORK_PATH_ZIP}" > checksum.txt

	echo "XCFramework created and zipped at ${FRAMEWORK_PATH_ZIP}"
else
	echo "Error: ${FRAMEWORK_PATH} not found." exit 1
fi

# Zip the XCFramework
if [ -d "${FRAMEWORK_PATH_MMKVWatchExtension}" ]; then
	# Sign the XCFramework
	codesign --timestamp -v --sign "Apple Distribution: Covantex LLC (8JPF68MSBL)" "${FRAMEWORK_PATH_MMKVWatchExtension}"
	codesign --verify --deep --strict "${FRAMEWORK_PATH_MMKVWatchExtension}"
	codesign -dv "${FRAMEWORK_PATH}"
	codesign -vv "${FRAMEWORK_PATH}"

	# Zip the XCFramework & Preserve symlinks using the -y option
	cd "${OUTPUT_DIC}" && zip -ryqo "${FRAMEWORK_PATH_ZIP_MMKVWatchExtension}" "${FRAMEWORK_PATH_MMKVWatchExtension}"

	# Compute and write checksum
	swift package compute-checksum "${FRAMEWORK_PATH_ZIP_MMKVWatchExtension}" > checksum_MMKVWatchExtension.txt

	echo "XCFramework created and zipped at ${FRAMEWORK_PATH_ZIP_MMKVWatchExtension}"
else
	echo "Error: ${FRAMEWORK_PATH_MMKVWatchExtension} not found." exit 1
fi

echo "...finish"
