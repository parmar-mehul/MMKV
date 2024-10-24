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
            checksum: "487c54acd74c0f936b13f69292a266bdc997906fbe894e8a120ddac51e0eb17c"
        ),
        .testTarget(name: "MMKVTests", dependencies: ["MMKV"]),
    ]
)
