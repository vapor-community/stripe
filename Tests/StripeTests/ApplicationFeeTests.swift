//
//  ApplicationFeeTests.swift
//  StripeTests
//
//  Created by Andrew Edwards on 3/17/19.
//

import XCTest
@testable import Stripe
@testable import Vapor

class ApplicationFeeTests: XCTestCase {
    let applicationFeeRefundString = """
{
    "id": "fr_1EEtTKKbnvuxQXGuFmk1SX9S",
    "object": "fee_refund",
    "amount": 100,
    "balance_transaction": "bt_1234",
    "created": 1552807914,
    "currency": "usd",
    "fee": "fee_1B73DOKbnvuxQXGuhY8Aw0TN",
    "metadata": {}
}
"""
    
    let applicationfeeString = """
{
  "id": "fee_1B73DOKbnvuxQXGuhY8Aw0TN",
  "object": "application_fee",
  "account": "acct_164wxjKbnvuxQXGu",
  "amount": 105,
  "amount_refunded": 105,
  "application": "ca_32D88BD1qLklliziD7gYQvctJIhWBSQ7",
  "balance_transaction": "txn_19XJJ02eZvKYlo2ClwuJ1rbA",
  "charge": "ch_1B73DOKbnvuxQXGurbwPqzsu",
  "created": 1506609734,
  "currency": "gbp",
  "livemode": false,
  "originating_transaction": null,
  "refunded": true,
  "refunds": {
    "object": "list",
    "data": [
      {
        "id": "fr_D0s7fGBKB40Twy",
        "object": "fee_refund",
        "amount": 138,
        "balance_transaction": "txn_1CaqNg2eZvKYlo2C75cA3Euk",
        "created": 1528486576,
        "currency": "usd",
        "fee": "fee_1B73DOKbnvuxQXGuhY8Aw0TN",
        "metadata": {}
      }
    ],
    "has_more": false,
    "total_count": 1,
    "url": "/v1/application_fees/fee_1B73DOKbnvuxQXGuhY8Aw0TN/refunds"
  }
}
"""
    
    
    func testApplicationFeeRefundParsesProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: applicationFeeRefundString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let refund = try decoder.decode(StripeApplicationFeeRefund.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop()).wait()
            
            XCTAssertEqual(refund.id, "fr_1EEtTKKbnvuxQXGuFmk1SX9S")
            XCTAssertEqual(refund.object, "fee_refund")
            XCTAssertEqual(refund.amount, 100)
            XCTAssertEqual(refund.balanceTransaction, "bt_1234")
            XCTAssertEqual(refund.created, Date(timeIntervalSince1970: 1552807914))
            XCTAssertEqual(refund.currency, .usd)
            XCTAssertEqual(refund.fee, "fee_1B73DOKbnvuxQXGuhY8Aw0TN")
            XCTAssertEqual(refund.metadata, [:])
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testApplicationFeeParsesProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: applicationfeeString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let fee = try decoder.decode(StripeApplicationFee.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop()).wait()
            
            XCTAssertEqual(fee.id, "fee_1B73DOKbnvuxQXGuhY8Aw0TN")
            XCTAssertEqual(fee.object, "application_fee")
            XCTAssertEqual(fee.balanceTransaction, "txn_19XJJ02eZvKYlo2ClwuJ1rbA")
            XCTAssertEqual(fee.amount, 105)
            XCTAssertEqual(fee.amountRefunded, 105)
            XCTAssertEqual(fee.created, Date(timeIntervalSince1970: 1506609734))
            XCTAssertEqual(fee.currency, .gbp)
            XCTAssertEqual(fee.refunded, true)
            XCTAssertNotNil(fee.refunds?.data)
        } catch {
            XCTFail("\(error)")
        }
    }
}
