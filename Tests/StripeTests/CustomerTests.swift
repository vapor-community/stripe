//
//  CustomerTests.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//

import XCTest
@testable import Stripe
@testable import Vapor

class CustomerTests: XCTestCase {
    let customerString = """
{
  "id": "cus_CG7FIUH6U4JTkB",
  "object": "customer",
  "account_balance": 0,
  "created": 1517702745,
  "currency": "usd",
  "default_source": "scr_123456",
  "delinquent": false,
  "description": "A customer",
  "discount": null,
  "email": "abc@xyz.com",
  "livemode": false,
  "metadata": {
  },
  "shipping": null,
  "sources": null,
  "subscriptions": null
}
"""
    
    func testCustomerParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: customerString)
            let futureCustomer = try decoder.decode(StripeCustomer.self, from: body, maxSize: 65_536, on: EmbeddedEventLoop())

            futureCustomer.do { (customer) in
                XCTAssertEqual(customer.id, "cus_CG7FIUH6U4JTkB")
                XCTAssertEqual(customer.object, "customer")
                XCTAssertEqual(customer.accountBalance, 0)
                XCTAssertEqual(customer.created, Date(timeIntervalSince1970: 1517702745))
                XCTAssertEqual(customer.currency, .usd)
                XCTAssertEqual(customer.defaultSource, "scr_123456")
                XCTAssertEqual(customer.delinquent, false)
                XCTAssertEqual(customer.description, "A customer")
                XCTAssertEqual(customer.email, "abc@xyz.com")
                XCTAssertEqual(customer.livemode, false)
                
                }.catch { (error) in
                    XCTFail("\(error.localizedDescription)")
            }
        }
        catch {
            XCTFail("\(error.localizedDescription)")
        }
    }
}
