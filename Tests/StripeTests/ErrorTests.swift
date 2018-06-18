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
    "error": {
        "type": "card_error",
        "charge": "ch_12345",
        "message": "Sorry kiddo",
        "code": "token_already_used",
        "decline_code": "stolen_card",
        "param": "card_number"
    }
}
"""
    
    func testErrorParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: errorString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let futureError = try decoder.decode(StripeError.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            futureError.do { (stripeError) in
                XCTAssertEqual(stripeError.error.type, .cardError)
                XCTAssertEqual(stripeError.error.charge, "ch_12345")
                XCTAssertEqual(stripeError.error.message, "Sorry kiddo")
                XCTAssertEqual(stripeError.error.code, .tokenAlreadyUsed)
                XCTAssertEqual(stripeError.error.declineCode, .stolenCard)
                XCTAssertEqual(stripeError.error.param, "card_number")
                
                }.catch { (error) in
                    XCTFail("\(error.localizedDescription)")
            }
        }
        catch {
            XCTFail("\(error.localizedDescription)")
        }
    }
}
