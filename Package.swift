// swift-tools-version:5.3

import PackageDescription

let libcmarkAsmFilePaths = [
    "src/case_fold_switch.inc",
    "src/entities.inc"
]

let package = Package(
    name: "MarkdownKit",
    platforms: [.iOS(.v13)],
    products: [
        .library(name: "MarkdownKit", targets: ["MarkdownKit"])
    ],
    targets: [
        .target(
            name: "libcmark",
            exclude: libcmarkAsmFilePaths,
            cSettings: libcmarkAsmFilePaths.map { CSetting.headerSearchPath($0) }
        ),
        .target(name: "MarkdownKitObjC"),
        .target(name: "MarkdownKit", dependencies: ["libcmark", "MarkdownKitObjC"]),
        .testTarget(name: "MarkdownKitTests", dependencies: ["MarkdownKit"])
    ],
    swiftLanguageVersions: [.v5]
)
