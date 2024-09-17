// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MMKV",
    products: [.library(name: "MMKV", targets: ["MMKV"])],
    targets: [
        .binaryTarget(
            name: "MMKV",
			url: "https://github.com/parmar-mehul/MMKV-XCFramework/releases/download/1.3.9/MMKV.xcframework.zip",
            checksum: "a7fe3890fcbedc4a20ecdee4d7751fe48e85cf9d14fae632ddb259c97836881e"
        ),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
