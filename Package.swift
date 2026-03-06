// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "ShiftRepeater",
    platforms: [.macOS(.v13)],
    targets: [
        .executableTarget(
            name: "ShiftRepeater",
            path: "Sources"
        )
    ]
)
