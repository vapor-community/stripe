//
//  BalanceTests.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/14/17.
//
//

import XCTest
@testable import Stripe
@testable import Vapor

class BalanceTests: XCTestCase {
    let balanceString = """
{
  "object": "balance",
  "available": [
    {
      "currency": "usd",
      "amount": 32147287853,
      "source_types": {
        "card": 32026441972,
        "bank_account": 119300699
      }
    },
   ],
  "connect_reserved": [
    {
      "currency": "eur",
      "amount": 0
    },
    {
      "currency": "nzd",
      "amount": 0
    },
    ],
  "livemode": false,
  "pending": [
    {
      "currency": "cad",
      "amount": -21092,
      "source_types": {
        "card": -21092
      }
    },
    {
      "currency": "jpy",
      "amount": 0,
      "source_types": {
      }
    },
    {
      "currency": "aud",
      "amount": -33,
      "source_types": {
      }
    },
    {
      "currency": "gbp",
      "amount": -81045,
      "source_types": {
      }
    }
  ]
}
"""
    
    func testBalanceParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: balanceString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let futureBalance = try decoder.decode(StripeBalance.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            futureBalance.do { (balance) in
                XCTAssertEqual(balance.object, "balance")
                XCTAssertEqual(balance.livemode, false)
                
                // BalanceTransfer
                XCTAssertEqual(balance.available[0].currency, .usd)
                XCTAssertEqual(balance.available[0].amount, 32147287853)
                XCTAssertEqual(balance.available[0].sourceTypes?["card"], 32026441972)
                // TODO: - Seeif this camel case is resolved in future versions of swift 4.1 snapshot
                XCTAssertEqual(balance.available[0].sourceTypes?["bank_account"], 119300699)
                
                XCTAssertEqual(balance.connectReserved[0].currency, .eur)
                XCTAssertEqual(balance.connectReserved[0].amount, 0)
                XCTAssertEqual(balance.connectReserved[1].currency, .nzd)
                XCTAssertEqual(balance.connectReserved[1].amount, 0)
                
                XCTAssertEqual(balance.pending[0].currency, .cad)
                XCTAssertEqual(balance.pending[0].amount, -21092)
                XCTAssertEqual(balance.pending[0].sourceTypes?["card"], -21092)
                XCTAssertEqual(balance.pending[1].currency, .jpy)
                XCTAssertEqual(balance.pending[1].amount, 0)
                XCTAssertEqual(balance.pending[2].currency, .aud)
                XCTAssertEqual(balance.pending[2].amount, -33)
                XCTAssertEqual(balance.pending[3].currency, .gbp)
                XCTAssertEqual(balance.pending[3].amount, -81045)
                
                }.catch { (error) in
                    XCTFail("\(error)")
            }
        }
        catch {
            XCTFail("\(error.localizedDescription)")
        }
    }
    
    let balanceTransactionString = """
{
  "id": "txn_19XJJ02eZvKYlo2ClwuJ1rbA",
  "object": "balance_transaction",
  "amount": 999,
  "available_on": 1483920000,
  "created": 1483315442,
  "currency": "usd",
  "description": null,
  "exchange_rate": 12.5,
  "fee": 59,
  "fee_details": [
    {
      "amount": 59,
      "application": null,
      "currency": "usd",
      "description": "Stripe processing fees",
      "type": "stripe_fee"
    }
  ],
  "net": 940,
  "source": "ch_19XJJ02eZvKYlo2CHfSUsSpl",
  "status": "pending",
  "type": "charge"
}
"""
    
    func testBalanceTransactionParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: balanceTransactionString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let futureBalanceTransaction = try decoder.decode(StripeBalanceTransactionItem.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            futureBalanceTransaction.do { (balancetransaction) in
                XCTAssertEqual(balancetransaction.id, "txn_19XJJ02eZvKYlo2ClwuJ1rbA")
                XCTAssertEqual(balancetransaction.object, "balance_transaction")
                XCTAssertEqual(balancetransaction.amount, 999)
                XCTAssertEqual(balancetransaction.availableOn, Date(timeIntervalSince1970: 1483920000))
                XCTAssertEqual(balancetransaction.created, Date(timeIntervalSince1970: 1483315442))
                XCTAssertEqual(balancetransaction.currency, .usd)
                XCTAssertEqual(balancetransaction.exchangeRate, 12.5)
                XCTAssertEqual(balancetransaction.fee, 59)
                XCTAssertEqual(balancetransaction.net, 940)
                XCTAssertEqual(balancetransaction.source, "ch_19XJJ02eZvKYlo2CHfSUsSpl")
                XCTAssertEqual(balancetransaction.status, .pending)
                XCTAssertEqual(balancetransaction.type, .charge)
                
                // Fee
                XCTAssertEqual(balancetransaction.feeDetails?[0].amount, 59)
                XCTAssertEqual(balancetransaction.feeDetails?[0].currency, .usd)
                XCTAssertEqual(balancetransaction.feeDetails?[0].description, "Stripe processing fees")
                XCTAssertEqual(balancetransaction.feeDetails?[0].type, .stripeFee)
                
                }.catch { (error) in
                    XCTFail("\(error.localizedDescription)")
            }
        }
        catch {
            XCTFail("\(error.localizedDescription)")
        }
    }
}
