// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Stripe",
    products: [
        .library(name: "Stripe", targets: ["Stripe"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "2.0.0"),
        .package(url: "https://github.com/vapor/random.git", from: "1.0.0"),
    ],
    targets: [
        .target(name: "Stripe", dependencies: ["Vapor", "Random]),
        .testTarget(name: "StripeTests", dependencies: ["Stripe"]),
    ]
)
