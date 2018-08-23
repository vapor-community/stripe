//
//  PayoutTests.swift
//  StripeTests
//
//  Created by Andrew Edwards on 8/21/18.
//

import XCTest
@testable import Stripe
@testable import Vapor

class PayoutTests: XCTestCase {
    let payoutString = """
{
  "id": "po_1D1MTmAU9AiAmxbB7b7ip35l",
  "object": "payout",
  "amount": 1100,
  "arrival_date": 1534806490,
  "automatic": true,
  "balance_transaction": "txn_1CSGjlAU9AiAmxbBWLHOEEsM",
  "created": 1534806490,
  "currency": "usd",
  "description": "STRIPE PAYOUT",
  "destination": "ba_1D1MTmAU9AiAmxbBTLh21RGt",
  "failure_balance_transaction": null,
  "failure_code": "invalid_account_number",
  "failure_message": "sorry kiddo",
  "livemode": false,
  "metadata": {
  },
  "method": "instant",
  "source_type": "card",
  "statement_descriptor": null,
  "status": "in_transit",
  "type": "bank_account"
}
"""
    func testPayoutsParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: payoutString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let payout = try decoder.decode(StripePayout.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop()).wait()
            
            XCTAssertEqual(payout.id, "po_1D1MTmAU9AiAmxbB7b7ip35l")
            XCTAssertEqual(payout.object, "payout")
            XCTAssertEqual(payout.amount, 1100)
            XCTAssertEqual(payout.arrivalDate, Date(timeIntervalSince1970: 1534806490))
            XCTAssertEqual(payout.automatic, true)
            XCTAssertEqual(payout.balanceTransaction, "txn_1CSGjlAU9AiAmxbBWLHOEEsM")
            XCTAssertEqual(payout.created, Date(timeIntervalSince1970: 1534806490))
            XCTAssertEqual(payout.currency, .usd)
            XCTAssertEqual(payout.description, "STRIPE PAYOUT")
            XCTAssertEqual(payout.failureBalanceTransaction, nil)
            XCTAssertEqual(payout.failureCode, .invalidAccountNumber)
            XCTAssertEqual(payout.failureMessage, "sorry kiddo")
            XCTAssertEqual(payout.livemode, false)
            XCTAssertEqual(payout.metadata, [:])
            XCTAssertEqual(payout.method, .instant)
            XCTAssertEqual(payout.sourceType, .card)
            XCTAssertEqual(payout.statementDescriptor, nil)
            XCTAssertEqual(payout.status, .inTransit)
            XCTAssertEqual(payout.type, .bankAccount)
            
        } catch {
            XCTFail("\(error)")
        }
    }
}
