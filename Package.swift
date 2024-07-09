// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MMKVXCFramework",
    products: [.library(name: "MMKV", targets: ["MMKV"])],
    targets: [
        .binaryTarget(
            name: "MMKV",
			url: "https://github.com/parmar-mehul/MMKV-XCFramework/releases/download/1.3.7/MMKV.xcframework.zip",
            checksum: "279ec929a18f6cda7c42edc8b6f124ae28d274b6d1b01894acff1a4caae89058"
        ),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
