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
    
    var drop: Droplet?
    var orderId: String = ""
    
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
            
            orderId = try drop?.stripe?.orders.create(currency: .usd,
                                                      coupon: nil,
                                                      customer: nil,
                                                      email: nil,
                                                      items: items,
                                                      shipping: shippingInfo).serializedResponse().id ?? ""
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
        orderId = ""
    }
    
    func testRetrieveOrder() throws {
        do {
            let order = try drop?.stripe?.orders.retrieve(order: orderId).serializedResponse()
            
            XCTAssertNotNil(order)
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
    
    func testUpdateOrder() throws {
        do {
            let metadata = try Node(node:["hello":"world"])
            
            let updatedOrder = try drop?.stripe?.orders.update(order: orderId,
                                                               coupon: nil,
                                                               selectedShippingMethod: nil,
                                                               shippingInformation: nil,
                                                               status: nil,
                                                               metadata: metadata).serializedResponse()
            
            XCTAssertNotNil(updatedOrder)
            
            XCTAssertEqual(updatedOrder?.metadata?["hello"], metadata["hello"])
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
    
    func testPayOrder() throws {
        do {
            
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
                                                              email: "john@sno.com").serializedResponse()
            
            XCTAssertNotNil(paidOrder)
            
            XCTAssertEqual(paidOrder?.status, .paid)
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
    
    func testListAllOrders() throws {
        do {
            let orders = try drop?.stripe?.orders.listAll(filter: nil).serializedResponse()
            
            XCTAssertNotNil(orders)
            
            if let orderItems = orders?.items {
                XCTAssertGreaterThanOrEqual(orderItems.count, 1)
            } else {
                XCTFail("Orders are not present")
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
    
    func testFilterOrders() throws {
        do {
            let filter = StripeFilter()
            
            filter.limit = 1
            
            let orders = try drop?.stripe?.orders.listAll(filter: filter).serializedResponse()
            
            XCTAssertNotNil(orders)
            
            if let orderItems = orders?.items {
                XCTAssertEqual(orderItems.count, 1)
            } else {
                XCTFail("Orders are not present")
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
    
    func testReturnOrder() throws {
        do {
            
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
                                                         email: "john@sno.com").serializedResponse()
            
            XCTAssertNotNil(paidOrder)
            
            XCTAssertEqual(paidOrder?.status, .paid)
            
            let returnedOrder = try drop?.stripe?.orders.return(order: orderId, items: nil).serializedResponse()
            
            XCTAssertNotNil(returnedOrder)
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
