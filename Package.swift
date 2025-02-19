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
			url: "https://github.com/parmar-mehul/MMKV-XCFramework/releases/download/2.1.0/MMKV.xcframework.zip",
            checksum: "137f3be6aad193a9195c4e484f34d06d7be713b4e0a1a81b32ca7fd55e274d5b"
        ),
		.binaryTarget(
			name: "MMKVWatchExtension",
			url: "https://github.com/parmar-mehul/MMKV-XCFramework/releases/download/2.1.0/MMKVWatchExtension.xcframework.zip", // hypothetical
			checksum: "3ebc4ce2f9cdfc502da2147150373f10946e9f1d1f69589e82ac8f2bffb513b3"
		),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
