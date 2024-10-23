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
            checksum: "b82c0734a04d550517f513a6100eaf5c42f2f0501995eed10f34b2d9e847878e"
        ),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
