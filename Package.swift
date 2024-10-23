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
            checksum: "700c2f92b3e259765c0c1cb6a9b25755c7b728e28c5f9cece6cb8f6024117899"
        ),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
