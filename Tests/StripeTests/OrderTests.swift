//
//  OrderTests.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import XCTest
@testable import Stripe
@testable import Vapor

class OrderTests: XCTestCase {
    let orderString = """
{
    "amount": 1500,
    "created": 1234567890,
    "currency": "usd",
    "id": "or_1BoJ2NKrZ43eBVAbFf4SZyvD",
    "items": [
        {
            "amount": 1500,
            "currency": "usd",
            "description": "Gold Special",
            "object": "order_item",
            "parent": "sk_1BoJ2KKrZ43eBVAbu7ioKR0i",
            "quantity": null,
            "type": "sku"
        }
    ],
    "livemode": false,
    "metadata": {
        "hello": "world"
    },
    "object": "order",
    "returns": {
        "data": [
            {
                "amount": 1500,
                "created": 1234567890,
                "currency": "usd",
                "id": "orret_1BoJ2NKrZ43eBVAb8r8dx0GO",
                "items": [
                    {
                        "amount": 1500,
                        "currency": "usd",
                        "description": "Gold Special",
                        "object": "order_item",
                        "parent": "sk_1BoJ2NKrZ43eBVAb4RD4HHuH",
                        "quantity": null,
                        "type": "sku"
                    }
                ],
                "livemode": false,
                "object": "order_return",
                "order": "or_1BoJ2NKrZ43eBVAbSnN443id",
                "refund": "re_1BoJ2NKrZ43eBVAbop3rb4h1"
            }
        ],
        "has_more": false,
        "object": "list",
        "total_count": 1,
        "url": "/v1/order_returns?order=or_1BoJ2NKrZ43eBVAbFf4SZyvD"
    },
    "shipping": {
        "address": {
            "city": "Anytown",
            "country": "US",
            "line1": "1234 Main street",
            "line2": "suite 123",
            "postal_code": "123456",
            "state": "AL"
        },
        "carrier": "UPS",
        "name": "Jenny Rosen",
        "phone": null,
        "tracking_number": null
    },
    "shipping_methods": [],
    "status": "created",
    "status_transitions": {
        "canceled": 1515290550,
        "fulfiled": 1507690550,
        "paid": 1517688550,
        "returned": 1927690550
    },
    "updated": 1234567890
}
"""
    
    func testOrderIsProperlyParsed() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970

            let body = HTTPBody(string: orderString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let futureOrder = try decoder.decode(StripeOrder.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            futureOrder.do { (order) in
                XCTAssertEqual(order.id, "or_1BoJ2NKrZ43eBVAbFf4SZyvD")
                XCTAssertEqual(order.amount, 1500)
                XCTAssertEqual(order.created, Date(timeIntervalSince1970: 1234567890))
                XCTAssertEqual(order.currency, .usd)
                XCTAssertEqual(order.livemode, false)
                XCTAssertEqual(order.metadata["hello"], "world")
                XCTAssertEqual(order.object, "order")
                XCTAssertEqual(order.status, .created)
                
                // This test covers the Order Item object
                XCTAssertEqual(order.statusTransitions?.canceled, Date(timeIntervalSince1970: 1515290550))
                XCTAssertEqual(order.statusTransitions?.fulfiled, Date(timeIntervalSince1970: 1507690550))
                XCTAssertEqual(order.statusTransitions?.paid, Date(timeIntervalSince1970: 1517688550))
                XCTAssertEqual(order.statusTransitions?.returned, Date(timeIntervalSince1970: 1927690550))
                XCTAssertEqual(order.updated, Date(timeIntervalSince1970: 1234567890))
                
                XCTAssertEqual(order.items?[0].amount, 1500)
                XCTAssertEqual(order.items?[0].currency, .usd)
                XCTAssertEqual(order.items?[0].description, "Gold Special")
                XCTAssertEqual(order.items?[0].object, "order_item")
                XCTAssertEqual(order.items?[0].parent, "sk_1BoJ2KKrZ43eBVAbu7ioKR0i")
                XCTAssertEqual(order.items?[0].quantity, nil)
                XCTAssertEqual(order.items?[0].type, .sku)
                
                XCTAssertEqual(order.returns?.hasMore, false)
                XCTAssertEqual(order.returns?.object, "list")
                XCTAssertEqual(order.returns?.url, "/v1/order_returns?order=or_1BoJ2NKrZ43eBVAbFf4SZyvD")
                
                // This test covers the OrderItem Return object
                XCTAssertEqual(order.returns?.data?[0].amount, 1500)
                XCTAssertEqual(order.returns?.data?[0].created, Date(timeIntervalSince1970: 1234567890))
                XCTAssertEqual(order.returns?.data?[0].currency, .usd)
                XCTAssertEqual(order.returns?.data?[0].id, "orret_1BoJ2NKrZ43eBVAb8r8dx0GO")
                XCTAssertEqual(order.returns?.data?[0].livemode, false)
                XCTAssertEqual(order.returns?.data?[0].object, "order_return")
                XCTAssertEqual(order.returns?.data?[0].order, "or_1BoJ2NKrZ43eBVAbSnN443id")
                XCTAssertEqual(order.returns?.data?[0].refund, "re_1BoJ2NKrZ43eBVAbop3rb4h1")
                
                XCTAssertEqual(order.shipping?.address?.city, "Anytown")
                XCTAssertEqual(order.shipping?.address?.country, "US")
                XCTAssertEqual(order.shipping?.address?.line1, "1234 Main street")
                XCTAssertEqual(order.shipping?.address?.line2, "suite 123")
                XCTAssertEqual(order.shipping?.address?.postalCode, "123456")
                XCTAssertEqual(order.shipping?.address?.state, "AL")
                XCTAssertEqual(order.shipping?.carrier, "UPS")
                XCTAssertEqual(order.shipping?.name, "Jenny Rosen")
                XCTAssertEqual(order.shipping?.phone, nil)
                XCTAssertEqual(order.shipping?.trackingNumber, nil)
                
                }.catch { (error) in
                    XCTFail("\(error)")
            }
        }
        catch  {
            XCTFail("\(error)")
        }
    }
}
