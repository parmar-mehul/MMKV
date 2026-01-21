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
			url: "https://github.com/parmar-mehul/MMKV-XCFramework/releases/download/2.3.0/MMKV.xcframework.zip",
            checksum: "a76539f8d9677c24ab20ca9b2726bd0f0e81b88f6188c848265a491b0bd8bbc7"
        ),
		.binaryTarget(
			name: "MMKVWatchExtension",
			url: "https://github.com/parmar-mehul/MMKV-XCFramework/releases/download/2.3.0/MMKVWatchExtension.xcframework.zip", // hypothetical
			checksum: "f7d04313b0850972dcf50030b53b705a7287b679f668ab485f70cdfe25e51bc5"
		),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
