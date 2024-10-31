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
            checksum: "86806075cb2a84d23d6679bdde890be44dac18fbb337397c591430b19cee4ddf"
        ),
		.binaryTarget(
			name: "MMKVWatchExtension",
			url: "https://github.com/parmar-mehul/MMKV-XCFramework/releases/download/2.0.0/MMKVWatchExtension.xcframework.zip", // hypothetical
			checksum: "20ffff022caca220d871dd4e23005274378cf22a0ec988582bcc1458e53052a5"
		),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
