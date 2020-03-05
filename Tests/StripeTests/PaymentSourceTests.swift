//
//  PaymentSourceTests.swift
//  Stripe
//
//  Created by Nicolas Bachschmidt on 2018-08-09.
//

import XCTest
@testable import Stripe
@testable import Vapor

class PaymentSourceTests: XCTestCase {
    let sourceListString = """
{
  "object": "list",
  "total_count": 3,
  "data": [
    {
      "id": "card_1Cs8z3GaLcnLeFWiU9SDCez8",
      "object": "card",
      "address_city": null,
      "address_country": null,
      "address_line1": null,
      "address_line1_check": null,
      "address_line2": null,
      "address_state": null,
      "address_zip": null,
      "address_zip_check": null,
      "brand": "Visa",
      "country": "FR",
      "customer": "cus_D3t6eeIn7f2nYi",
      "cvc_check": "pass",
      "dynamic_last4": null,
      "exp_month": 12,
      "exp_year": 2029,
      "fingerprint": "GhnGuMVuycvktkHE",
      "funding": "credit",
      "last4": "0003",
      "metadata": {
      },
      "name": null,
      "tokenization_method": null,
      "type": "Visa"
    },
    {
      "id": "src_1CxF9xGaLcnLeFWif1vfiSkS",
      "object": "source",
      "ach_credit_transfer": {
        "account_number": "test_49b8d100bde6",
        "bank_name": "TEST BANK",
        "fingerprint": "0W7zV79lnzu4L4Ie",
        "routing_number": "110000000",
        "swift_code": "TSTEZ122"
      },
      "amount": null,
      "client_secret": "src_client_secret_DO1CKYXtHAFzKMNPY4Fsi7d9",
      "created": 1533825041,
      "currency": "usd",
      "flow": "receiver",
      "livemode": false,
      "metadata": {
      },
      "owner": {
        "address": null,
        "email": "jenny.rosen@example.com",
        "name": null,
        "phone": null,
        "verified_address": null,
        "verified_email": null,
        "verified_name": null,
        "verified_phone": null
      },
      "receiver": {
        "address": "110000000-test_49b8d100bde6",
        "amount_charged": 0,
        "amount_received": 1000,
        "amount_returned": 0,
        "refund_attributes_method": "email",
        "refund_attributes_status": "missing"
      },
      "statement_descriptor": null,
      "status": "chargeable",
      "type": "ach_credit_transfer",
      "usage": "reusable"
    },
    {
      "id": "ba_1CxEzUGaLcnLeFWiz0fJrOVm",
      "object": "bank_account",
      "account_holder_name": "",
      "account_holder_type": "individual",
      "bank_name": "STRIPE TEST BANK",
      "country": "US",
      "currency": "usd",
      "customer": "cus_D3t6eeIn7f2nYi",
      "disabled": false,
      "fingerprint": "xrXW6SzxS6Gjr4d7",
      "last4": "6789",
      "metadata": {
      },
      "name": "",
      "routing_number": "110000000",
      "status": "new",
      "validated": false,
      "verified": false
    }
  ],
  "has_more": false,
  "url": "/v1/customers/cus_D3t6eeIn7f2nYi/sources"
}
"""
    
    func testSourceListIsProperlyParsed() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: sourceListString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let futureOrder = try decoder.decode(StripeSourcesList.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            futureOrder.do { list in
                XCTAssertEqual(list.object, "list")
                XCTAssertEqual(list.hasMore, false)
                XCTAssertEqual(list.data?.count, 3)
                XCTAssertEqual(list.bankAccounts?.count, 1)
                XCTAssertEqual(list.cards?.count, 1)
                XCTAssertEqual(list.sources?.count, 1)
                XCTAssertEqual(list.data?.map { $0.id }, [
                    "card_1Cs8z3GaLcnLeFWiU9SDCez8",
                    "src_1CxF9xGaLcnLeFWif1vfiSkS",
                    "ba_1CxEzUGaLcnLeFWiz0fJrOVm",
                ])
                XCTAssertEqual(list.data?.map { $0.object }, ["card", "source", "bank_account"])

            }.catch { (error) in
                XCTFail("\(error)")
            }
        }
        catch  {
            XCTFail("\(error)")
        }
    }
}
