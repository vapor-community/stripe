// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "Stripe",
    platforms: [
        .macOS(.v10_14)
    ],
    products: [
        .library(name: "Stripe", targets: ["Stripe"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-beta"),
        .package(url: "https://github.com/vapor-community/StripeKit.git", from: "1.0.11"),
    ],
    targets: [
        .target(name: "Stripe", dependencies: ["Vapor","StripeKit"]),
        .testTarget(name: "StripeTests", dependencies: ["Vapor", "Stripe","StripeKit"])
    ]
)
