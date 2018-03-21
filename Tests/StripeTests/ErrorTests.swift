//
//  ErrorTests.swift
//  StripeTests
//
//  Created by Andrew Edwards on 2/27/18.
//

import XCTest
@testable import Stripe
@testable import Vapor

class ErrorTests: XCTestCase {
    let errorString = """
{
    "type": "card_error",
    "charge": "ch_12345",
    "message": "Sorry kiddo",
    "code": "invalid_swipe_data",
    "decline_code": "stolen_card",
    "param": "card_number"
}
"""
    
    func testErrorParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let body = HTTPBody(string: errorString)
            let futureError = try decoder.decode(StripeAPIError.self, from: body)
            
            futureError.do { (stripeError) in
                XCTAssertEqual(stripeError.type, .cardError)
                XCTAssertEqual(stripeError.charge, "ch_12345")
                XCTAssertEqual(stripeError.message, "Sorry kiddo")
                XCTAssertEqual(stripeError.code, .invalidSwipeData)
                XCTAssertEqual(stripeError.declineCode, .stolenCard)
                XCTAssertEqual(stripeError.param, "card_number")
                
                }.catch { (error) in
                    XCTFail("\(error.localizedDescription)")
            }
        }
        catch {
            XCTFail("\(error.localizedDescription)")
        }
    }
}
