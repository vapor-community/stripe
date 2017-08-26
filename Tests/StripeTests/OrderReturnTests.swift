//
//  OrderReturnTests.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/25/17.
//
//

import XCTest

@testable import Stripe
@testable import Vapor
@testable import Models
@testable import API
@testable import Helpers
@testable import Errors

class OrderReturnTests: XCTestCase {
    
    var drop: Droplet?
    var orderReturnId: String = ""
    
    override func setUp() {
        do {
            drop = try makeDroplet()
            
            let productId = try drop?.stripe?.products.create(name: "Vapor Node",
                                                              id: nil,
                                                              active: nil,
                                                              attributes: try Node(node:["size"]),
                                                              caption: nil,
                                                              deactivateOn: nil,
                                                              description: "A Vapor Node",
                                                              images: nil,
                                                              packageDimensions: nil,
                                                              shippable: true,
                                                              url: nil)
                                                              .serializedResponse().id ?? ""
            
            let inventory = try Node(node:[
                "quantity":55,
                "type":InventoryType.finite.rawValue,])
            
            
            let attributes = try Node(node:["size": "xl"])
            
            let skuId = try drop?.stripe?.skus.create(currency: .usd,
                                                      inventory: inventory,
                                                      price: 2500,
                                                      product: productId,
                                                      id: nil,
                                                      active: nil,
                                                      attributes: attributes,
                                                      image: nil,
                                                      packageDimensions: nil)
                .serializedResponse().id ?? ""
            
            let items = try Node(node: [["parent": skuId]])
            
            let shippingInfo = Node([
                "name": "Mr. Vapor",
                "address": ["line1": "123 main street"]
                ])
            
            let orderId = try drop?.stripe?.orders.create(currency: .usd,
                                                      coupon: nil,
                                                      customer: nil,
                                                      email: nil,
                                                      items: items,
                                                      shipping: shippingInfo).serializedResponse().id ?? ""
            
            let source = Node([
                "exp_month": 12,
                "exp_year": 2020,
                "number": "4242424242424242",
                "object": "card",
                "cvc": 123
                ])
            
            let paidOrder = try drop?.stripe?.orders.pay(order: orderId,
                                                         customer: nil,
                                                         source: source,
                                                         applicationFee: nil,
                                                         email: "john@sno.com").serializedResponse().id ?? ""
            
            orderReturnId = try drop?.stripe?.orders.return(order: paidOrder, items: nil).serializedResponse().id ?? ""
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    override func tearDown() {
        drop = nil
        orderReturnId = ""
    }
    
    func testRetrieveOrderReturn() throws {
        do {
            let orderReturn = try drop?.stripe?.orderReturns.retrieve(orderReturn: orderReturnId).serializedResponse()
            
            XCTAssertNotNil(orderReturn)
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testListAllOrderReturns() throws {
        do {
            let orderReturns = try drop?.stripe?.orderReturns.listAll(filter: nil).serializedResponse()
            
            XCTAssertNotNil(orderReturns)
            
            if let orderReturnItems = orderReturns?.items {
                XCTAssertGreaterThanOrEqual(orderReturnItems.count, 1)
            } else {
                XCTFail("OrderReturns are not present")
            }
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testFilterOrderReturns() throws {
        do {
            let filter = StripeFilter()
            
            filter.limit = 1
            
            let orderReturns = try drop?.stripe?.orderReturns.listAll(filter: filter).serializedResponse()
            
            XCTAssertNotNil(orderReturns)
            
            if let orderReturnItems = orderReturns?.items {
                XCTAssertEqual(orderReturnItems.count, 1)
            } else {
                XCTFail("OrderReturns are not present")
            }
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
}
