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
    
    var drop: Droplet?
    var chargeId: String = ""
    
    override func setUp()
    {
        do
        {
            drop = try self.makeDroplet()
            
            let tokenId = try drop?.stripe?.tokens.createCard(withCardNumber: "4242 4242 4242 4242",
                                                                   expirationMonth: 10,
                                                                   expirationYear: 2018,
                                                                   cvc: 123,
                                                                   name: "Test Card")
                                                                   .serializedResponse().id ?? ""
            
            chargeId = try drop?.stripe?.charge.create(amount: 10_00,
                                                         in: .usd,
                                                         for: .source(tokenId),
                                                         description: "Vapor Stripe: Test Description")
                                                         .serializedResponse().id ?? ""
        }
        catch
        {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    func testCharge() throws
    {
        let paymentToken = try drop?.stripe?.tokens.createCard(withCardNumber: "4242 4242 4242 4242",
                                                              expirationMonth: 10,
                                                              expirationYear: 2018,
                                                              cvc: 123,
                                                              name: "Test Card")
                                                              .serializedResponse()
        
        let object = try drop?.stripe?.charge.create(amount: 10_00,
                                                     in: .usd,
                                                     for: .source(paymentToken?.id ?? ""),
                                                     description: "Vapor Stripe: Test Description")
                                                     .serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testRetrieveCharge() throws
    {
        let object = try drop?.stripe?.charge.retrieve(charge: chargeId).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testListAllCharges() throws
    {
        let object = try drop?.stripe?.charge.listAll().serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testFilterAllCharges() throws
    {
        let filter = StripeFilter()
        filter.limit = 1
        let object = try drop?.stripe?.charge.listAll(filter: filter).serializedResponse()
        XCTAssertEqual(object?.items.count, 1)
    }
    
    func testChargeUpdate() throws
    {
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
        let object = try drop?.stripe?.charge.update(charge: chargeId,
                                                     metadata: metadata,
                                                     receiptEmail: "test-email@test.com",
                                                     shippingLabel: shippingLabel)
                                                     .serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testChargeCapture() throws
    {
        let paymentToken = try drop?.stripe?.tokens.createCard(withCardNumber: "4242 4242 4242 4242",
                                                               expirationMonth: 10,
                                                               expirationYear: 2018,
                                                               cvc: 123,
                                                               name: "Test Card")
                                                               .serializedResponse().id ?? ""
        
        let uncapturedCharge = try drop?.stripe?.charge.create(amount: 10_00,
                                                               in: .usd,
                                                               for: .source(paymentToken),
                                                               description: "Vapor Stripe: test Description",
                                                               capture: false)
                                                               .serializedResponse().id ?? ""
        
        let object = try drop?.stripe?.charge.capture(charge: uncapturedCharge).serializedResponse()
        XCTAssertNotNil(object)
    }
}

