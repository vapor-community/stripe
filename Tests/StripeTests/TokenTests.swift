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
    ]

    func testTokenCreation() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.tokens.create(cardNumber: "4242 4242 4242 4242", expirationMonth: 10, expirationYear: 2018, cvc: 123, name: "Test Card").serializedResponse()
        XCTAssertNotNil(object)
    }
    
}
