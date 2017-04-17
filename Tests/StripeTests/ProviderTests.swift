import XCTest
@testable import Stripe
@testable import Vapor

class ProviderTests: XCTestCase {

    static var allTests = [
        ("testProvider", testProvider),
    ]

    func testProvider() throws {
        let config = Config([
            "stripe": [
                "apiKey": "API_KEY"
            ],
        ])
        let drop = try Droplet(config: config)
        try drop.addProvider(Stripe.Provider.self)
        XCTAssertEqual(drop.stripe?.apiKey, "API_KEY")
    }
}
