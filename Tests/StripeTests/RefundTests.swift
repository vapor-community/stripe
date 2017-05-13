//
//  RefundTests.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/13/17.
//
//

import XCTest
@testable import Stripe
@testable import Vapor
@testable import Models
@testable import API

class RefundTests: XCTestCase {
    
    static var allTests = [
        ("testRefunding", testRefunding),
        ("testUpdatingRefund", testUpdatingRefund),
        ("testRetrievingRefund", testRetrievingRefund),
        ("testListingAllRefunds", testListingAllRefunds)
    ]
    
    func testRefunding() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.refunds.refund(charge: TestChargeID).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testUpdatingRefund() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.refunds.update(refund: TestRefundID, metadata: ["test": "Test Updating a charge"]).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testRetrievingRefund() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.refunds.retrieve(refund: TestRefundID).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testListingAllRefunds() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.refunds.listAll().serializedResponse()
        XCTAssertGreaterThanOrEqual(object!.items!.count, 2)
    }
    
}
