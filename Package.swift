// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "MarkdownKit",
    products: [
        .library(name: "cmark", targets: ["cmark"]),
        .library(name: "MarkdownKit", targets: ["MarkdownKit"])
    ],
    dependencies: [],
    targets: [
        .target(name: "cmark"),
        .target(name: "MarkdownKit", dependencies: ["cmark"]),
        .testTarget(name: "MarkdownKitTests", dependencies: ["MarkdownKit"])
    ]
)
