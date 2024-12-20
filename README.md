# MMKV-XCFramework for [Tencent/MMKV](https://github.com/Tencent/MMKV)

This repository hosts the MMKV framework for iOS, macOS, macOS Catalyst, tvOS, and watchOS as an XCFramework, distributed via Swift Package Manager (SPM) XCFramework.

## Framework Contents

This XCFramework includes the following targets for different platforms:
- **MMKV-iOS**: For iOS devices.
- **MMKV-iOS-Simulator**: For iOS Simulator.
- **MMKV-macOS-Catalyst**: For macOS Catalyst (iPad apps running on macOS).
- **MMKV-macOS**: For native macOS.
- **MMKV-tvOS**: For tvOS devices.
- **MMKV-tvOS-Simulator**: For tvOS Simulator.
- **MMKVWatchExtension**: For watchOS devices.
- **MMKVWatchExtension-Simulator**: For watchOS Simulator.

## XCFramework Architectures

The XCFramework is created by combining multiple architectures to support various platforms. Currently, the following architectures are supported:

- **iOS**:
  - `ios-arm64`
  - `ios-arm64_x86_64-simulator`
  - `ios-arm64_x86_64-maccatalyst`
  
- **macOS**:
  - `macos-arm64_x86_64`

- **watchOS**:
  - `watchos-arm64`
  - `watchos-arm64_32_armv7k`
  - `watchos-arm64_i386_x86_64-simulator`
  
- **tvOS**:
  - `tvos-arm64`
  - `tvos-arm64_x86_64-simulator`

## Requirements

- **Xcode**: Version 16.2 or later
- **Swift**: Version 5.10 or later

## Integration via Swift Package Manager

To use the MMKV XCFramework in your project via Swift Package Manager (SPM), follow these steps:

1. Open your Xcode project.
2. Go to **File > Add Packages**.
3. Enter the URL of this repository in the search field.
4. Choose the version and the desired targets you want to include in your project.
5. Click **Add Package**.

The MMKV framework will now be integrated into your project and ready for use.

```swift
#if os(watchOS)
import MMKVWatchExtension // Watch-specific
#else
import MMKV // iOS, macOS, tvOS
#endif
```

## Supported Platforms

This XCFramework supports:
- iOS
- macOS
- macOS Catalyst
- tvOS
- watchOS

### Benefits of XCFrameworks
- Multi-Platform Support: Bundle code for iOS, macOS, tvOS, and watchOS in a single framework.
- Simplicity and Maintenance: Easier version management and reduced complexity in dependency management.
- Binary Compatibility: Ensures compatibility across different architectures, making it easier to distribute and use the framework.

### What If I cant to generate XCFramework again by my self
- Clone [Tencent/MMKV Master branch](https://github.com/Tencent/MMKV.git)
- Clone [parmar-mehul/MMKV Master branch](https://github.com/parmar-mehul/MMKV.git)
- Make sure clone both on same folder
- Update `script_generate_xcframeworks.sh` as per your sytem if you want to generate new XCframwork, otherwise, existing framework will work fine, don't worry
    - OUTPUT_DIC
    - CODESIGN_APPLE_DISTRIBUTION_CERTIFICATE_NAME
    - PASSWORD_FOR_UNLOCK_KEYCHAIN

## Notes

- This XCFramework is built for **distribution** using `BUILD_LIBRARY_FOR_DISTRIBUTION=YES`, ensuring compatibility with binary frameworks and future Swift versions.
- Make sure to select the correct target platform when using MMKV in your project to avoid compatibility issues.
- Clearing SPMs package cache is the only way I know how to mitigate issue of below issue. The package caches lives at:
> checksum of downloaded artifact of binary target [...] does not match checksum specified by the manifest [...]
```
rm -rf ~/Library/Developer/Xcode/DerivedData
rm -rf ~/Library/Caches/org.swift.swiftpm
rm -rf ~/Library/org.swift.swiftpm/configuration
rm -rf ~/Library/org.swift.swiftpm/security

Re-fetch the package dependencies by selecting File > Packages > Reset Package Caches in Xcode.
```
