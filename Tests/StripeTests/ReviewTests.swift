//
//  ReviewTests.swift
//  StripeTests
//
//  Created by Andrew Edwards on 3/27/19.
//

import XCTest
@testable import Stripe
@testable import Vapor

class ReviewTests: XCTestCase {
    let reviewString = """
{
  "id": "prv_1EINwPAU9AiAmxbBOAS8nEnl",
  "object": "review",
  "billing_zip": null,
  "charge": "ch_19yUdh2eZvKYlo2CkFVBOZG7",
  "closed_reason": null,
  "created": 1553640021,
  "ip_address": null,
  "ip_address_location": {
    "city": "Nowhere",
    "country": "US",
    "latitude": 0.00000,
    "longitude": 12.00000,
    "region": "CA"
    },
  "livemode": false,
  "open": true,
  "opened_reason": "rule",
  "reason": "refunded_as_fraud",
  "session": {
    "browser": "Safari",
    "device": "iPhone",
    "platform": "macOS",
    "version": "10.14.4"
    }
}
"""
    
    func testTopUpParsesProperly() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let body = HTTPBody(string: reviewString)
        var headers: HTTPHeaders = [:]
        headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
        let request = HTTPRequest(headers: headers, body: body)
        let review = try decoder.decode(StripeReview.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop()).wait()
        
        XCTAssertEqual(review.billingZip, nil)
        XCTAssertEqual(review.created, Date(timeIntervalSince1970: 1553640021))
        XCTAssertEqual(review.ipAddressLocation?.city, "Nowhere")
        XCTAssertEqual(review.ipAddressLocation?.country, "US")
        XCTAssertEqual(review.ipAddressLocation?.latitude, 0.00000)
        XCTAssertEqual(review.ipAddressLocation?.longitude, 12.00000)
        XCTAssertEqual(review.openedReason, .rule)
        XCTAssertEqual(review.reason, .refundedAsFraud)
        XCTAssertEqual(review.session?.browser, "Safari")
        XCTAssertEqual(review.session?.device, "iPhone")
        XCTAssertEqual(review.session?.platform, "macOS")
        XCTAssertEqual(review.session?.version, "10.14.4")
    }
    
}
