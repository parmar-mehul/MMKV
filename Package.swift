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
            checksum: "87800757df268fe3d4a6bb27c03b8da5de393bea87ed927d59bd8a6a190f8425"
        ),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
