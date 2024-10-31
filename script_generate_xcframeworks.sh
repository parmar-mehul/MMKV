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
rm -rf ~/Library/Developer/Xcode/DerivedData/*
rm -rf "${OUTPUT_DIC}" # Ensure output directory is fully cleared
mkdir -p "${OUTPUT_DIC}"
echo "Cleaned Derived Data and created output directory"

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
archive_framework "${SCHEME_NAME}" iphoneos "iOS" "iOS"
archive_framework "${SCHEME_NAME}" iphonesimulator "iOS-Simulator" "iOS Simulator"
archive_framework "${SCHEME_NAME}" appletvos "tvOS" "tvOS"
archive_framework "${SCHEME_NAME}" appletvsimulator "tvOS-Simulator" "tvOS Simulator"
archive_framework "${SCHEME_NAME}" "macosx" "macOS-Catalyst" "macOS,variant=Mac Catalyst,name=Any Mac"
archive_framework "${SCHEME_NAME}" "macosx" "macOS" "macOS"

archive_framework "MMKVWatchExtension" watchos "watchOS" "watchOS"
archive_framework "MMKVWatchExtension" watchsimulator "watchOS-Simulator" "watchOS Simulator"


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

# Zip the XCFramework
if [ -d "${FRAMEWORK_PATH}" ]; then
	# Sign the XCFramework -> Here, password to unlock default: KEYCHAIN_PASSWORD, Enter your computer password to unlock keychain and find and sign certificate to .xcframework file
	# 	To check if certificate is available or not, Use terminal and enter "security find-identity -v -p codesigning", you can find valid identities
	security unlock-keychain -p "parmar" login.keychain

	# codesign tool allows you to set the signature identifier for XCFramework (or binary)
	codesign --sign "Apple Distribution: Covantex LLC (8JPF68MSBL)" -v "${FRAMEWORK_PATH}" --timestamp --preserve-metadata=identifier,entitlements,flags --generate-entitlement-der

	# Verify the signature on a signed binary, Verify the integrity of the signed binary framework
	codesign -vv "${FRAMEWORK_PATH}"

	# Display the signature of the binary framework
	codesign --timestamp --display --verbose "${FRAMEWORK_PATH}"

	security lock-keychain login.keychain

	# Zip the XCFramework, Use ditto to compress an XCFramework with the option --keepParent
	#	This same error can crop up if you fail to include the –keepParent option because as Xcode unpacks the XCFramework,
	#	it’ll expand itself into a different name, and you’ll be right back at the same “does not contain the expected binary” error message.
	ditto -c -k --sequesterRsrc --keepParent "${FRAMEWORK_PATH}" "${FRAMEWORK_PATH_ZIP}"

	# Check the checksum is a SHA256 digest of the zip, so you can also use openssl to get the same result compare to (swift package compute-checksum):
	openssl dgst -sha256 "${FRAMEWORK_PATH_ZIP}"

	# Once the XCFramework is compressed, compute the checksum. The Apple documentation offers the command: swift package compute-checksum
	# 	Compute and write checksum
	cd "${OUTPUT_DIC}" && swift package compute-checksum "${FRAMEWORK_PATH_ZIP}" > checksum.txt

	echo "XCFramework compressed and compute-checksum & verified with openssl dgst, finally saved checksum.txt file"
	echo "XCFramework as Remote binary target within a Package.swift, created and zipped at ${FRAMEWORK_PATH_ZIP}"
else
	echo "Error: ${FRAMEWORK_PATH} not found." exit 1
fi

# Zip the XCFramework
if [ -d "${FRAMEWORK_PATH_MMKVWatchExtension}" ]; then
	# Sign the XCFramework -> Here, password to unlock default: KEYCHAIN_PASSWORD, Enter your computer password to unlock keychain and find and sign certificate to .xcframework file
	# 	To check if certificate is available or not, Use terminal and enter "security find-identity -v -p codesigning", you can find valid identities
	security unlock-keychain -p "parmar" login.keychain

	# codesign tool allows you to set the signature identifier for XCFramework (or binary)
	codesign --sign "Apple Distribution: Covantex LLC (8JPF68MSBL)" -v "${FRAMEWORK_PATH_MMKVWatchExtension}" --timestamp --preserve-metadata=identifier,entitlements,flags --generate-entitlement-der

	# Verify the signature on a signed binary, Verify the integrity of the signed binary framework
	codesign -vv "${FRAMEWORK_PATH_MMKVWatchExtension}"

	# Display the signature of the binary framework
	codesign --timestamp --display --verbose "${FRAMEWORK_PATH_MMKVWatchExtension}"

	security lock-keychain login.keychain

	# Zip the XCFramework, Use ditto to compress an XCFramework with the option --keepParent
	#	This same error can crop up if you fail to include the –keepParent option because as Xcode unpacks the XCFramework,
	#	it’ll expand itself into a different name, and you’ll be right back at the same “does not contain the expected binary” error message.
	ditto -c -k --sequesterRsrc --keepParent "${FRAMEWORK_PATH_MMKVWatchExtension}" "${FRAMEWORK_PATH_ZIP_MMKVWatchExtension}"

	# Check the checksum is a SHA256 digest of the zip, so you can also use openssl to get the same result compare to (swift package compute-checksum):
	openssl dgst -sha256 "${FRAMEWORK_PATH_ZIP_MMKVWatchExtension}"

	# Once the XCFramework is compressed, compute the checksum. The Apple documentation offers the command: swift package compute-checksum
	# 	Compute and write checksum
	cd "${OUTPUT_DIC}" && swift package compute-checksum "${FRAMEWORK_PATH_ZIP_MMKVWatchExtension}" > checksum_MMKVWatchExtension.txt

	echo "XCFramework compressed and compute-checksum & verified with openssl dgst, finally saved checksum.txt file"
	echo "XCFramework as Remote binary target within a Package.swift, created and zipped at ${FRAMEWORK_PATH_ZIP_MMKVWatchExtension}"
else
	echo "Error: ${FRAMEWORK_PATH_MMKVWatchExtension} not found." exit 1
fi

echo "...finish"

