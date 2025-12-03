// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ClashMac",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(
            name: "ClashMac",
            targets: ["ClashMac"]
        ),
    ],
    dependencies: [
        // 添加依赖项（如果需要）
    ],
    targets: [
        .executableTarget(
            name: "ClashMac",
            dependencies: [],
            path: "ClashMac",
            sources: [
                "ClashMacApp.swift",
                "Models",
                "Views",
                "Controllers",
                "Store",
                "API",
                "Utils"
            ],
            resources: [
                .process("../Resources")
            ]
        ),
    ]
)

