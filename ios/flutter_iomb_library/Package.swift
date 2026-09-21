// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "flutter_iomb_library",
    platforms: [.iOS("13.0")],
    products: [
        .library(name: "flutter-iomb-library", targets: ["flutter_iomb_library"])
    ],
    dependencies: [
        .package(name: "FlutterFramework", path: "../FlutterFramework"),
        .package(url: "https://github.com/INFOnline-sg/libs-appsensor-iomb-ios.git", exact: "1.2.0")
    ],
    targets: [
        .target(
            name: "flutter_iomb_library",
            dependencies: [
                .product(name: "FlutterFramework", package: "FlutterFramework"),
                .product(name: "IOMbLibrary", package: "libs-appsensor-iomb-ios")
            ]
        )
    ]
)
