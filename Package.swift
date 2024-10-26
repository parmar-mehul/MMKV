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
			url: "https://github.com/parmar-mehul/MMKV-XCFramework/releases/download/2.0.0/MMKV.xcframework.zip",
            checksum: "abd8a02d64fcf9acbb728980453d6fe6af56e5cbcad9927da4ce8e887d68e889"
        ),
		.binaryTarget(
			name: "MMKVWatchExtension",
			url: "https://github.com/parmar-mehul/MMKV-XCFramework/releases/download/2.0.0/MMKVWatchExtension.xcframework.zip", // hypothetical
			checksum: "70d14e20cf87cf9b15f31a152ebd15fd8d5aaca5cb91373a6945492072d0752c"
		),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
