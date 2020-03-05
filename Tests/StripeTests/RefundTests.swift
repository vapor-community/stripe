//
//  RefundTests.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/13/17.
//
//

import XCTest
@testable import Stripe
@testable import Vapor

class RefundTests: XCTestCase {
    let refundString = """
{
  "id": "re_1BrXqE2eZvKYlo2Cfa7NO6GF",
  "object": "refund",
  "amount": 1000,
  "balance_transaction": "txn_1BrXqE2eZvKYlo2CyAuEMg17",
  "charge": "ch_1BrXqD2eZvKYlo2Ce1sYPCDd",
  "created": 1517690550,
  "currency": "usd",
  "metadata": {
    "hello": "world"
  },
  "reason": "requested_by_customer",
  "receipt_number": "23760348",
  "status": "succeeded"
}
"""
    
    func testRefundParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: refundString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let futureRefund = try decoder.decode(StripeRefund.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            futureRefund.do { (refund) in
                XCTAssertEqual(refund.id, "re_1BrXqE2eZvKYlo2Cfa7NO6GF")
                XCTAssertEqual(refund.object, "refund")
                XCTAssertEqual(refund.amount, 1000)
                XCTAssertEqual(refund.balanceTransaction, "txn_1BrXqE2eZvKYlo2CyAuEMg17")
                XCTAssertEqual(refund.charge, "ch_1BrXqD2eZvKYlo2Ce1sYPCDd")
                XCTAssertEqual(refund.created, Date(timeIntervalSince1970: 1517690550))
                XCTAssertEqual(refund.currency, .usd)
                XCTAssertEqual(refund.metadata["hello"], "world")
                XCTAssertEqual(refund.reason, .requestedByCustomer)
                XCTAssertEqual(refund.receiptNumber, "23760348")
                XCTAssertEqual(refund.status, .succeeded)
                
                }.catch { (error) in
                    XCTFail("\(error.localizedDescription)")
            }
        }
        catch {
            XCTFail("\(error.localizedDescription)")
        }
    }
}
