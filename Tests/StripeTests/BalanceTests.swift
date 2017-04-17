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
        let object = try drop.stripe?.balance.retrieveBalance(forTransaction: TestTransactionID).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testBalanceHistory() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.balance.history().serializedResponse()
        XCTAssertNotNil(object)
    }
    
}
