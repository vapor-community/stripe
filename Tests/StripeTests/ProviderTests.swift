import XCTest
@testable import Stripe
@testable import Vapor

class ProviderTests: XCTestCase {

    static var allTests = [
        ("testProvider", testProvider),
    ]

    func testProvider() throws {
        let drop = try makeDroplet()
        XCTAssertEqual(drop.stripe?.apiKey, "API_KEY")
    }
}
