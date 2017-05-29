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
    
    static var allTests = [
        ("testTokenCreation", testTokenCreation),
        ("testTokenRetrieval", testTokenRetrieval),
        ("testBankAccountCreation", testBankAccountCreation),
    ]

    var drop: Droplet?
    var tokenId: String = ""
    
    override func setUp()
    {
        do
        {
            drop = try self.makeDroplet()
            
            tokenId = try drop?.stripe?.tokens.createCard(withCardNumber: "4242 4242 4242 4242",
                                                             expirationMonth: 10,
                                                             expirationYear: 2018,
                                                             cvc: 123,
                                                             name: "Test Card").serializedResponse().id ?? ""
        }
        catch
        {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    func testTokenCreation() throws
    {
        let object = try drop?.stripe?.tokens.createCard(withCardNumber: "4242 4242 4242 4242",
                                                         expirationMonth: 10,
                                                         expirationYear: 2018,
                                                         cvc: 123,
                                                         name: "Test Card").serializedResponse()
        XCTAssertNotNil(object?.card)
    }
    
    func testTokenRetrieval() throws
    {
        let object = try drop?.stripe?.tokens.retrieve(tokenId).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testBankAccountCreation() throws {
        let object = try drop?.stripe?.tokens.createBank(country: "US",
                                                         currency: .usd,
                                                         accountNumber: "000123456789",
                                                         routingNumber: "110000000",
                                                         accountHolderName: "Test Person",
                                                         accountHolderType: "Individual").serializedResponse()
        XCTAssertNotNil(object?.bankAccount)
    }
}
