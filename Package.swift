// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Stripe",
    targets: [
        Target(name: "Stripe"),
    ],
    dependencies: [
        .Package(url: "https://github.com/vapor/vapor.git", majorVersion: 2),
        .Package(url: "https://github.com/vapor/random.git", majorVersion: 1),
    ]
)
