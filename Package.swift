// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Stripe",
    targets: [
        Target(name: "Errors"),
        Target(name: "Helpers", dependencies: ["Errors"]),
        Target(name: "Models", dependencies: ["Helpers"]),
        Target(name: "API", dependencies: ["Models", "Errors", "Helpers"]),
        Target(name: "Stripe", dependencies: ["API", "Models", "Errors", "Helpers"]),
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", Version(2,0,0, prereleaseIdentifiers: ["beta"])),
    ]
)
