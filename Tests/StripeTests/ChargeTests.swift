//
//  ChargeTests.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import XCTest

@testable import Stripe
@testable import Vapor

class ChargeTests: XCTestCase {

    static var allTests = [
        ("testCharge", testCharge),
        ("testRetrieveCharge", testRetrieveCharge)
    ]
    
    func testCharge() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.charge.create(amount: 10_000, in: .usd, for: .source(TestChargeSourceTokenID), description: "Vapor Stripe: Test Description").serializedResponse()
        print(object?.id ?? "No ID")
        XCTAssertNotNil(object)
    }
    
    func testRetrieveCharge() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.charge.retrieve(charge: TestChargeID).serializedResponse()
        print(object?.id ?? "No ID")
        XCTAssertNotNil(object)
    }
}

