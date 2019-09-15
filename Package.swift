// swift-tools-version:5.0

import PackageDescription

let package = Package(
    name: "TimePoint",
    products: [
        .library(
            name: "TimePoint",
            targets: ["TimePoint"]
        ),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "TimePoint",
            dependencies: []
        ),
        .testTarget(
            name: "TimePointTests",
            dependencies: ["TimePoint"]
        ),
    ]
)
