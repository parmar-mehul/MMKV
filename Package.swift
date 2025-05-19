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
			url: "https://github.com/parmar-mehul/MMKV-XCFramework/releases/download/2.2.2/MMKV.xcframework.zip",
            checksum: "c355bc52c0c2425c6a8f89bb3e73c24d3d3fd623c6a478ebdf979084f95b35b5"
        ),
		.binaryTarget(
			name: "MMKVWatchExtension",
			url: "https://github.com/parmar-mehul/MMKV-XCFramework/releases/download/2.2.2/MMKVWatchExtension.xcframework.zip", // hypothetical
			checksum: "92c0741f58fd54b8fc44c400c033ac7e0bc91a36e1cb8a6b5bac325e67f2b281"
		),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
