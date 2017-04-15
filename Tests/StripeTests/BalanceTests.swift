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
        ("testBalanceHistoryTransactionitem", testBalanceHistoryTransactionitem),
        ("testBalanceHistory", testBalanceHistory),
    ]
    
    func testBalance() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.balance.retrieveBalance().serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testBalanceHistoryTransactionitem() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.balance.retrieveBalance(forTransaction: "txn_TRANSACTION_ID").serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testBalanceHistory() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.balance.history().serializedResponse()
        XCTAssertNotNil(object)
    }
    
}
