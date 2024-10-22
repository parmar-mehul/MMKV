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
            checksum: "bdebb2fb873950601b9d48efb550e99850bed7e107d4979174d91f6757bb1229"
        ),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
