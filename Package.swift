// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Stripe",
    targets: [
        Target(name: "Stripe")
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", Version(2,0,0, prereleaseIdentifiers: ["beta"])),
    ]
)
