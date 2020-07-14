// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "MarkdownKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "MarkdownKit", targets: ["MarkdownKit"])
    ],
    targets: [
        .target(name: "libcmark"),
        .target(name: "MarkdownKitObjC"),
        .target(name: "MarkdownKit", dependencies: ["libcmark", "MarkdownKitObjC"]),
        .testTarget(name: "MarkdownKitTests", dependencies: ["MarkdownKit"])
    ],
    swiftLanguageVersions: [.v5]
)
