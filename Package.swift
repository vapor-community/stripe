// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "Stripe",
    products: [
        .library(name: "Stripe", targets: ["Stripe"])
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", .branch("beta"))
    ],
    targets: [
        .target(name: "Stripe", dependencies: ["Vapor"]),
        .testTarget(name: "StripeTests", dependencies: ["Vapor", "Stripe"])
    ]
)
