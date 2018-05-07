// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Stripe",
    products: [
        .library(name: "Stripe", targets: ["Stripe"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
    ],
    targets: [
        .target(name: "Stripe", dependencies: ["Vapor"]),
        .testTarget(name: "StripeTests", dependencies: ["Vapor", "Stripe"])
    ]
)
