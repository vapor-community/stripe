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
@testable import Models
@testable import API

class ChargeTests: XCTestCase {

    static var allTests = [
        ("testCharge", testCharge),
        ("testRetrieveCharge", testRetrieveCharge),
        ("testListAllCharges", testListAllCharges),
        ("testFilterAllCharges", testFilterAllCharges),
        ("testChargeUpdate", testChargeUpdate),
        ("testChargeCapture", testChargeCapture)
    ]
    
    func testCharge() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.charge.create(amount: 10_000, in: .usd, for: .source(TestChargeSourceTokenID), description: "Vapor Stripe: Test Description").serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testRetrieveCharge() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.charge.retrieve(charge: TestChargeID).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testListAllCharges() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.charge.listAll().serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testFilterAllCharges() throws {
        let drop = try self.makeDroplet()
        let filter = Filter()
        filter.limit = 1
        let object = try drop.stripe?.charge.listAll(filter: filter).serializedResponse()
        XCTAssertEqual(object?.items.count, 1)
    }
    
    func testChargeUpdate() throws {
        let drop = try self.makeDroplet()
        let shippingAddress = ShippingAddress()
        shippingAddress.addressLine1 = "123 Test St"
        shippingAddress.addressLine2 = "456 Apt"
        shippingAddress.city = "Test City"
        shippingAddress.state = "CA"
        shippingAddress.postalCode = "12345"
        shippingAddress.country = "US"
        
        let shippingLabel = ShippingLabel()
        shippingLabel.name = "Test User"
        shippingLabel.phone = "555-111-2222"
        shippingLabel.carrier = "FedEx"
        shippingLabel.trackingNumber = "1234567890"
        shippingLabel.address = shippingAddress
        
        let metadata = ["test": "metadata"]
        let object = try drop.stripe?.charge.update(charge: TestChargeID, metadata: metadata, receiptEmail: "test-email@test.com", shippingLabel: shippingLabel).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testChargeCapture() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.charge.capture(charge: TestChargeID).serializedResponse()
        XCTAssertNotNil(object)
    }
}

