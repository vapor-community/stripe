//
//  BalanceTests.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/14/17.
//
//

import XCTest

@testable import Stripe
@testable import Vapor

extension XCTestCase {
    func makeDroplet() throws -> Droplet {
        let config = Config([
            "stripe": [
                "apiKey": "API_KEY" // Add your own API Key for tests
            ],
        ])
        let drop = try Droplet(config: config)
        try drop.addProvider(Stripe.Provider.self)
        return drop
    }
}

class BalanceTests: XCTestCase {
    
    static var allTests = [
        ("testBalance", testBalance),
    ]
    
    func testBalance() throws {
        let drop = try self.makeDroplet()
        let balance = try drop.stripe?.balance.getBalance().serializedResponse()
        XCTAssertNotNil(balance)
    }
    
}
