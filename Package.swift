// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MMKV",
    products: [.library(name: "MMKV", targets: ["MMKV"])],
    targets: [
        .binaryTarget(
            name: "MMKV",
			url: "https://github.com/parmar-mehul/MMKV-XCFramework/releases/download/2.0.0/MMKV.xcframework.zip",
            checksum: "77c58b98af15f74fedc27963dad76eadfd7d21cb39b757621c20ed07bc7e5cef"
        ),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
