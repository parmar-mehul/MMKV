// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MMKV",
	platforms: [
		.iOS(.v13), .macOS(.v13), .watchOS(.v9), .tvOS(.v16)
	],
    products: [
		.library(name: "MMKV", targets: ["MMKV"]),
		.library(name: "MMKVWatchExtension", targets: ["MMKVWatchExtension"])
	],
    targets: [
        .binaryTarget(
            name: "MMKV",
			url: "https://github.com/parmar-mehul/MMKV-XCFramework/releases/download/2.0.1/MMKV.xcframework.zip",
            checksum: "70a3445a9adde855373ca1568dba51fc20171efae1da154fda58b8c9e6c35faa"
        ),
		.binaryTarget(
			name: "MMKVWatchExtension",
			url: "https://github.com/parmar-mehul/MMKV-XCFramework/releases/download/2.0.1/MMKVWatchExtension.xcframework.zip", // hypothetical
			checksum: "b9c68348a32b75e4b492b33bba0cb6f7e2a26e8a2dc2bdbc7e1147b9c7efb7eb"
		),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
