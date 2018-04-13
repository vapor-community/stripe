//
//  ChargeTests.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import XCTest
@testable import Stripe
@testable import Vapor
// TODO: - Implement Review tests
class ChargeTests: XCTestCase {
    let chargeString = """
{
  "id": "ch_1BrbM42eZvKYlo2CIu7qiNPF",
  "object": "charge",
  "amount": 999,
  "amount_refunded": 0,
  "application": "oops",
  "application_fee": "fee_something",
  "balance_transaction": "txn_19XJJ02eZvKYlo2ClwuJ1rbA",
  "captured": false,
  "created": 1517704056,
  "currency": "usd",
  "customer": "cus_A2FVP45tySz01V",
  "description": null,
  "destination": null,
  "dispute": null,
  "failure_code": "expired_card",
  "failure_message": "Your card has expired.",
  "fraud_details": {
  },
  "invoice": "in_1BqUzH2eZvKYlo2CV8BYZkYX",
  "livemode": false,
  "metadata": {
  },
  "on_behalf_of": "some account",
  "order": "order number",
  "outcome": {
    "network_status": "declined_by_network",
    "reason": "expired_card",
    "risk_level": "not_assessed",
    "seller_message": "The bank returned the decline code `expired_card`.",
    "type": "issuer_declined"
  },
  "paid": false,
  "receipt_email": "a@b.com",
  "receipt_number": "some number",
  "refunded": false,
  "refunds": {},
  "review": "prv_123456",
  "shipping": null,
  "source": null,
  "source_transfer": "sickness",
  "statement_descriptor": "for a shirt",
  "status": "failed",
  "transfer_group": "group a"
}
"""
    
    func testChargeParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: chargeString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let futureCharge = try decoder.decode(StripeCharge.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())

            futureCharge.do { (charge) in
                XCTAssertEqual(charge.id, "ch_1BrbM42eZvKYlo2CIu7qiNPF")
                XCTAssertEqual(charge.object, "charge")
                XCTAssertEqual(charge.amount, 999)
                XCTAssertEqual(charge.amountRefunded, 0)
                XCTAssertEqual(charge.application, "oops")
                XCTAssertEqual(charge.applicationFee, "fee_something")
                XCTAssertEqual(charge.balanceTransaction, "txn_19XJJ02eZvKYlo2ClwuJ1rbA")
                XCTAssertEqual(charge.captured, false)
                XCTAssertEqual(charge.created, Date(timeIntervalSince1970: 1517704056))
                XCTAssertEqual(charge.currency, .usd)
                XCTAssertEqual(charge.customer, "cus_A2FVP45tySz01V")
                XCTAssertEqual(charge.failureCode, "expired_card")
                XCTAssertEqual(charge.failureMessage, "Your card has expired.")
                XCTAssertEqual(charge.invoice, "in_1BqUzH2eZvKYlo2CV8BYZkYX")
                XCTAssertEqual(charge.livemode, false)
                XCTAssertEqual(charge.onBehalfOf, "some account")
                XCTAssertEqual(charge.order, "order number")
                
                // Outcome
                XCTAssertEqual(charge.outcome?.networkStatus, .declinedByNetwork)
                XCTAssertEqual(charge.outcome?.reason, "expired_card")
                XCTAssertEqual(charge.outcome?.riskLevel, .notAssessed)
                XCTAssertEqual(charge.outcome?.sellerMessage, "The bank returned the decline code `expired_card`.")
                XCTAssertEqual(charge.outcome?.type, .issuerDeclined)
                
                XCTAssertEqual(charge.paid, false)
                XCTAssertEqual(charge.receiptEmail, "a@b.com")
                XCTAssertEqual(charge.receiptNumber, "some number")
                XCTAssertEqual(charge.refunded, false)
                XCTAssertEqual(charge.review, "prv_123456")
                XCTAssertEqual(charge.sourceTransfer, "sickness")
                XCTAssertEqual(charge.statementDescriptor, "for a shirt")
                XCTAssertEqual(charge.status, .failed)
                XCTAssertEqual(charge.transferGroup, "group a")
                
                }.catch { (error) in
                    XCTFail("\(error.localizedDescription)")
            }
        }
        catch {
            XCTFail("\(error.localizedDescription)")
        }
    }
}
