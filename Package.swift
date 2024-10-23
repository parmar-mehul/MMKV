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
            checksum: "0c874c9dfcb238e0b89e4de2628e4d9b7302b096bae3e069ac4e4904f9b9983e"
        ),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
