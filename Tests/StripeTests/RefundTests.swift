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
        
    var drop: Droplet?
    var refundId: String = ""
    
    override func setUp() {
        do {
            drop = try self.makeDroplet()
            
            let tokenId = try drop?.stripe?.tokens.createCard(withCardNumber: "4242 4242 4242 4242",
                                                              expirationMonth: 10,
                                                              expirationYear: 2018,
                                                              cvc: 123,
                                                              name: "Test Card").serializedResponse().id ?? ""
            
            let chargeId = try drop?.stripe?.charge.create(amount: 10_00,
                                                         in: .usd,
                                                         for: .source(tokenId),
                                                         description: "Vapor Stripe: Test Description").serializedResponse().id ?? ""
            
            refundId = try drop?.stripe?.refunds.refund(charge: chargeId).serializedResponse().id ?? ""
        } catch {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    func testRefunding() throws {
        
        let paymentToken = try drop?.stripe?.tokens.createCard(withCardNumber: "4242 4242 4242 4242",
                                                               expirationMonth: 10,
                                                               expirationYear: 2018,
                                                               cvc: 123,
                                                               name: "Test Card").serializedResponse().id ?? ""
        
        let charge = try drop?.stripe?.charge.create(amount: 10_00,
                                                     in: .usd,
                                                     for: .source(paymentToken),
                                                     description: "Vapor Stripe: Test Description").serializedResponse().id ?? ""
        
        let object = try drop?.stripe?.refunds.refund(charge: charge).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testUpdatingRefund() throws {
        let object = try drop?.stripe?.refunds.update(refund: refundId, metadata: ["test": "Test Updating a charge"]).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testRetrievingRefund() throws {
        let object = try drop?.stripe?.refunds.retrieve(refund: refundId).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testListingAllRefunds() throws {
        let object = try drop?.stripe?.refunds.listAll().serializedResponse()
        XCTAssertGreaterThanOrEqual(object!.items!.count, 1)
    }    
}
