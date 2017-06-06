//
//  TokenTests.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/12/17.
//
//

import XCTest
@testable import Stripe
@testable import Vapor
@testable import Models
@testable import API

class TokenTests: XCTestCase {
    
    var drop: Droplet?
    var tokenId: String = ""
    
    override func setUp() {
        do {
            drop = try self.makeDroplet()
            
            tokenId = try drop?.stripe?.tokens.createCardToken(withCardNumber: "4242 4242 4242 4242",
                                                               expirationMonth: 10,
                                                               expirationYear: 2018,
                                                               cvc: 123,
                                                               name: "Test Card",
                                                               customer: nil,
                                                               currency: nil)
                                                               .serializedResponse().id ?? ""
        } catch {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    func testCardTokenCreation() throws {
        let object = try drop?.stripe?.tokens.createCardToken(withCardNumber: "4242 4242 4242 4242",
                                                              expirationMonth: 10,
                                                              expirationYear: 2018,
                                                              cvc: 123,
                                                              name: "Test Card",
                                                              customer: nil,
                                                              currency: nil)
                                                              .serializedResponse()
        XCTAssertNotNil(object?.card)
    }
    
    func testTokenRetrieval() throws {
        let object = try drop?.stripe?.tokens.retrieve(tokenId).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testBankAccountTokenCreation() throws {
        let object = try drop?.stripe?.tokens.createBankAccountToken(withAccountNumber: "000123456789",
                                                                     country: "US",
                                                                     currency: .usd,
                                                                     routingNumber: "110000000",
                                                                     accountHolderName: "Test Person",
                                                                     accountHolderType: "Individual",
                                                                     customer: nil).serializedResponse()
        XCTAssertNotNil(object?.bankAccount)
    }
}
