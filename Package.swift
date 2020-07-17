// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "SSMarkdownKit",
    platforms: [.iOS(.v9)],
    products: [
        .library(name: "SSMarkdownKit", targets: ["SSMarkdownKit"])
    ],
    targets: [
        .target(name: "libcmark"),
        .target(name: "SSMarkdownKitObjC"),
        .target(name: "SSMarkdownKit", dependencies: ["libcmark", "SSMarkdownKitObjC"]),
        .testTarget(name: "MarkdownKitTests", dependencies: ["SSMarkdownKit"])
    ],
    swiftLanguageVersions: [.v5]
)
