//
//  TopUpTests.swift
//  StripeTests
//
//  Created by Andrew Edwards on 3/24/19.
//

import XCTest
@testable import Stripe
@testable import Vapor

class TopUpTests: XCTestCase {
    let topupString = """
{
  "id": "tu_123456789",
  "object": "topup",
  "amount": 1000,
  "balance_transaction": null,
  "created": 123456789,
  "currency": "usd",
  "description": "Top-up description",
  "expected_availability_date": 123456789,
  "failure_code": "sorry",
  "failure_message": "we're sorry",
  "livemode": false,
  "metadata": {
    "order_id": "12345678"
  },
  "source": null,
  "statement_descriptor": null,
  "status": "pending",
  "transfer_group": null
}
"""
    
    func testTopUpParsesProperly() throws {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        let body = HTTPBody(string: topupString)
        var headers: HTTPHeaders = [:]
        headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
        let request = HTTPRequest(headers: headers, body: body)
        let topup = try decoder.decode(StripeTopUp.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop()).wait()
        
        XCTAssertEqual(topup.currency, .usd)
        XCTAssertEqual(topup.expectedAvailabilityDate, Date(timeIntervalSince1970: 123456789))
        XCTAssertEqual(topup.failureCode, "sorry")
        XCTAssertEqual(topup.failureMessage, "we're sorry")
        XCTAssertEqual(topup.metadata?["order_id"], "12345678")
    }
}
