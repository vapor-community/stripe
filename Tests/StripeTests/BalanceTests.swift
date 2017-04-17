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
@testable import API

class BalanceTests: XCTestCase {
    
    static var allTests = [
        ("testBalance", testBalance),
        ("testBalanceTransactionItem", testBalanceTransactionItem),
        ("testBalanceHistory", testBalanceHistory),
        ("testFilterBalanceHistory", testFilterBalanceHistory),
    ]
    
    func testBalance() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.balance.retrieveBalance().serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testBalanceTransactionItem() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.balance.retrieveBalance(forTransaction: TestTransactionID).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testBalanceHistory() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.balance.history().serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testFilterBalanceHistory() throws {
        let drop = try self.makeDroplet()
        let filter = Filter()
        filter.limit = 1
        let object = try drop.stripe?.balance.history(forFilter: filter).serializedResponse()
        XCTAssertEqual(object?.items.count, 1)
    }
    
}
