//
//  TransferTests.swift
//  StripeTests
//
//  Created by Andrew Edwards on 4/3/18.
//

import XCTest
@testable import Stripe
@testable import Vapor

class TransferTests: XCTestCase {
    let transferString = """
{
  "id": "tr_164xRv2eZvKYlo2CZxJZWm1E",
  "object": "transfer",
  "amount": 200,
  "amount_reversed": 200,
  "balance_transaction": "txn_19XJJ02eZvKYlo2ClwuJ1rbA",
  "created": 1432229235,
  "currency": "usd",
  "description": "transfers ahoy!",
  "destination": "acct_164wxjKbnvuxQXGu",
  "destination_payment": "py_164xRvKbnvuxQXGuVFV2pZo1",
  "livemode": false,
  "metadata": {
    "order_id": "6735"
  },
  "reversals": {
    "object": "list",
    "data": [
      {
        "id": "trr_1BGmS02eZvKYlo2CklK9McmT",
        "object": "transfer_reversal",
        "amount": 100,
        "balance_transaction": "txn_1BGmS02eZvKYlo2C9f16WPBN",
        "created": 1508928572,
        "currency": "usd",
        "metadata": {
            "hello":"world"
        },
        "transfer": "tr_164xRv2eZvKYlo2CZxJZWm1E"
      },
    ],
    "has_more": false,
    "total_count": 2,
    "url": "/v1/transfers/tr_164xRv2eZvKYlo2CZxJZWm1E/reversals"
  },
  "reversed": true,
  "source_transaction": "ch_164xRv2eZvKYlo2Clu1sIJWB",
  "source_type": "card",
  "transfer_group": "group_ch_164xRv2eZvKYlo2Clu1sIJWB"
}
"""
    
    func testTransferParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: transferString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let transfer = try decoder.decode(StripeTransfer.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            transfer.do { (tran) in
                
                XCTAssertEqual(tran.id, "tr_164xRv2eZvKYlo2CZxJZWm1E")
                XCTAssertEqual(tran.object, "transfer")
                XCTAssertEqual(tran.amount, 200)
                XCTAssertEqual(tran.amountReversed, 200)
                XCTAssertEqual(tran.balanceTransaction, "txn_19XJJ02eZvKYlo2ClwuJ1rbA")
                XCTAssertEqual(tran.created, Date(timeIntervalSince1970: 1432229235))
                XCTAssertEqual(tran.currency, .usd)
                XCTAssertEqual(tran.description, "transfers ahoy!")
                XCTAssertEqual(tran.destination, "acct_164wxjKbnvuxQXGu")
                XCTAssertEqual(tran.destinationPayment, "py_164xRvKbnvuxQXGuVFV2pZo1")
                XCTAssertEqual(tran.livemode, false)
                XCTAssertEqual(tran.metadata["order_id"], "6735")
                XCTAssertEqual(tran.reversed, true)
                XCTAssertEqual(tran.sourceTransaction, "ch_164xRv2eZvKYlo2Clu1sIJWB")
                XCTAssertEqual(tran.sourceType, "card")
                XCTAssertEqual(tran.transferGroup, "group_ch_164xRv2eZvKYlo2Clu1sIJWB")
                
                // This test covers the transfer reversal
                XCTAssertEqual(tran.reversals?.object, "list")
                XCTAssertEqual(tran.reversals?.hasMore, false)
                XCTAssertEqual(tran.reversals?.totalCount, 2)
                XCTAssertEqual(tran.reversals?.url, "/v1/transfers/tr_164xRv2eZvKYlo2CZxJZWm1E/reversals")
                XCTAssertEqual(tran.reversals?.data?[0].id, "trr_1BGmS02eZvKYlo2CklK9McmT")
                XCTAssertEqual(tran.reversals?.data?[0].object, "transfer_reversal")
                XCTAssertEqual(tran.reversals?.data?[0].amount, 100)
                XCTAssertEqual(tran.reversals?.data?[0].balanceTransaction, "txn_1BGmS02eZvKYlo2C9f16WPBN")
                XCTAssertEqual(tran.reversals?.data?[0].created, Date(timeIntervalSince1970: 1508928572))
                XCTAssertEqual(tran.reversals?.data?[0].metadata["hello"], "world")
                XCTAssertEqual(tran.reversals?.data?[0].transfer, "tr_164xRv2eZvKYlo2CZxJZWm1E")
            }.catch { (error) in
                 XCTFail("\(error.localizedDescription)")
            }
        }
        catch {
            XCTFail("\(error.localizedDescription)")
        }
    }
}
