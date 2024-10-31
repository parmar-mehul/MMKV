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
            checksum: "f6df44a94d0cc6f6a6222539565a9104d7153273b3c790a116f956bf392f0c29"
        ),
		.binaryTarget(
			name: "MMKVWatchExtension",
			url: "https://github.com/parmar-mehul/MMKV-XCFramework/releases/download/2.0.0/MMKVWatchExtension.xcframework.zip", // hypothetical
			checksum: "5c6b79a6ea78a73f8ac13f4c20967358335bbb57dd98d56cc26410ec09281497"
		),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
