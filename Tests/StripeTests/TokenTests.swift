//
//  TokenTests.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/12/17.
//
//

import XCTest
@testable import Stripe
@testable import Vapor

class TokenTests: XCTestCase {
    func testCardTokenParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: cardTokenString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let cardToken = try decoder.decode(StripeToken.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            cardToken.do { (token) in
                XCTAssertNil(token.bankAccount)
                XCTAssertNotNil(token.card)
                
                // This test covers the card object
                XCTAssertEqual(token.card?.id, "card_1BnxhQ2eZvKYlo2CPNu4CkoA")
                XCTAssertEqual(token.card?.object, "card")
                XCTAssertEqual(token.card?.addressCity, "Miami")
                XCTAssertEqual(token.card?.addressCountry, "US")
                XCTAssertEqual(token.card?.addressLine1, "123 Main Street")
                XCTAssertEqual(token.card?.addressLine1Check, .failed)
                XCTAssertEqual(token.card?.addressLine2, "Apt 123")
                XCTAssertEqual(token.card?.addressState, "Florida")
                XCTAssertEqual(token.card?.addressZip, "12345")
                XCTAssertEqual(token.card?.addressZipCheck, .pass)
                XCTAssertEqual(token.card?.brand, .visa)
                XCTAssertEqual(token.card?.country, "US")
                XCTAssertEqual(token.card?.cvcCheck, .pass)
                XCTAssertEqual(token.card?.dynamicLast4, "1234")
                XCTAssertEqual(token.card?.expMonth, 8)
                XCTAssertEqual(token.card?.expYear, 2019)
                XCTAssertEqual(token.card?.fingerprint, "Xt5EWLLDS7FJjR1c")
                XCTAssertEqual(token.card?.funding, .credit)
                XCTAssertEqual(token.card?.last4, "4242")
                XCTAssertEqual(token.card?.metadata?["hello"], "world")
                XCTAssertEqual(token.card?.name, "Vapor")
                XCTAssertEqual(token.card?.tokenizationMethod, .applePay)
                
                XCTAssertEqual(token.id, "tok_1BnxhQ2eZvKYlo2CVEbDC7jK")
                XCTAssertEqual(token.object, "token")
                XCTAssertEqual(token.clientIp, "0.0.0.0")
                XCTAssertEqual(token.created, Date(timeIntervalSince1970: 1516836636))
                XCTAssertEqual(token.livemode, false)
                XCTAssertEqual(token.type, .card)
                XCTAssertEqual(token.used, false)
            }.catch { (error) in
                XCTFail("\(error)")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }

    func testBankTokenParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: bankAccountTokenString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let bankToken = try decoder.decode(StripeToken.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            bankToken.do { (token) in
                XCTAssertNil(token.card)
                XCTAssertNotNil(token.bankAccount)
                
                // This test covers the bank account object
                XCTAssertEqual(token.bankAccount?.id, "ba_1BnxhQ2eZvKYlo2C5cM6hYK1")
                XCTAssertEqual(token.bankAccount?.object, "bank_account")
                XCTAssertEqual(token.bankAccount?.accountHolderName, "Jane Austen")
                XCTAssertEqual(token.bankAccount?.accountHolderType, .individual)
                XCTAssertEqual(token.bankAccount?.bankName, "STRIPE TEST BANK")
                XCTAssertEqual(token.bankAccount?.country, "US")
                XCTAssertEqual(token.bankAccount?.currency, .usd)
                XCTAssertEqual(token.bankAccount?.fingerprint, "1JWtPxqbdX5Gamtc")
                XCTAssertEqual(token.bankAccount?.last4, "6789")
                XCTAssertEqual(token.bankAccount?.metadata?["hello"], "world")
                XCTAssertEqual(token.bankAccount?.routingNumber, "110000000")
                XCTAssertEqual(token.bankAccount?.status, .new)
                
                XCTAssertEqual(token.id, "btok_1BnxhQ2eZvKYlo2CbYrQL91x")
                XCTAssertEqual(token.object, "token")
                XCTAssertEqual(token.clientIp, "0.0.0.0")
                XCTAssertEqual(token.created, Date(timeIntervalSince1970: 1516836636))
                XCTAssertEqual(token.livemode, false)
                XCTAssertEqual(token.type, .bankAccount)
                XCTAssertEqual(token.used, false)
                
            }.catch { (error) in
                XCTFail("\(error)")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
    
    let cardTokenString = """
{
  "id": "tok_1BnxhQ2eZvKYlo2CVEbDC7jK",
  "object": "token",
  "card": {
    "id": "card_1BnxhQ2eZvKYlo2CPNu4CkoA",
    "object": "card",
    "address_city":"Miami",
    "address_country":"US",
    "address_line1":"123 Main Street",
    "address_line1_check":"failed",
    "address_line2":"Apt 123",
    "address_state":"Florida",
    "address_zip":"12345",
    "address_zip_check":"pass",
    "brand": "Visa",
    "country": "US",
    "cvc_check": "pass",
    "dynamic_last4": "1234",
    "exp_month": 8,
    "exp_year": 2019,
    "fingerprint": "Xt5EWLLDS7FJjR1c",
    "funding": "credit",
    "last4": "4242",
    "metadata": {
        "hello": "world"
    },
    "name": "Vapor",
    "tokenization_method": "apple_pay"
  },
  "client_ip": "0.0.0.0",
  "created": 1516836636,
  "livemode": false,
  "type": "card",
  "used": false
}
"""
    
    let bankAccountTokenString = """
{
  "id": "btok_1BnxhQ2eZvKYlo2CbYrQL91x",
  "object": "token",
  "bank_account": {
    "id": "ba_1BnxhQ2eZvKYlo2C5cM6hYK1",
    "object": "bank_account",
    "account_holder_name": "Jane Austen",
    "account_holder_type": "individual",
    "bank_name": "STRIPE TEST BANK",
    "country": "US",
    "currency": "usd",
    "fingerprint": "1JWtPxqbdX5Gamtc",
    "last4": "6789",
    "metadata": {
        "hello": "world"
    },
    "routing_number": "110000000",
    "status": "new"
  },
  "client_ip": "0.0.0.0",
  "created": 1516836636,
  "livemode": false,
  "type": "bank_account",
  "used": false
}
"""
}
