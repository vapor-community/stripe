//
//  ProductTests.swift
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

class ProductTests: XCTestCase {
    
    var drop: Droplet?
    var productId: String = ""
    
    override func setUp() {
        do {
            drop = try makeDroplet()
            
            
            productId = try drop?.stripe?.products.create(name: "Vapor Node",
                                                          id: nil,
                                                          active: nil,
                                                          attributes: try Node(node:["size"]),
                                                          caption: nil,
                                                          deactivateOn: nil,
                                                          description: "A Vapor Node",
                                                          images: nil,
                                                          packageDimensions: nil,
                                                          shippable: nil,
                                                          url: nil)
                                                          .serializedResponse().id ?? ""
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
        productId = ""
    }
    
    func testRetrieveProduct() throws {
        do {
            let product = try drop?.stripe?.products.retrieve(product: productId).serializedResponse()
            
            XCTAssertNotNil(product)
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
    
    func testUpdateProduct() throws {
        do {
            let metadata = try Node(node:["hello":"world"])
            let attributes = try Node(node:["size","color"])
            let caption = "A super cool shirt"
            let description = "A new Vapor Node"
            let dimensions = Node([
                "height": 1,
                "length": 1,
                "weight": 1,
                "width": 1
                ])
            
            let updatedProduct = try drop?.stripe?.products.update(product: productId,
                                                               active: nil,
                                                               attributes: attributes,
                                                               caption: caption,
                                                               deactivateOn: nil,
                                                               description: description,
                                                               images: nil,
                                                               name: nil,
                                                               packageDimensions: dimensions,
                                                               shippable: nil,
                                                               url: nil,
                                                               metadata: metadata).serializedResponse()
            XCTAssertNotNil(updatedProduct)
            
            XCTAssertEqual(updatedProduct?.metadata?["hello"], metadata["hello"])
            
            XCTAssertEqual(updatedProduct?.attributes, attributes)
            
            XCTAssertEqual(updatedProduct?.caption, caption)
            
            XCTAssertEqual(updatedProduct?.description, description)
            
            XCTAssertEqual(updatedProduct?.packageDimensions?.height, Decimal(dimensions["height"]?.int ?? 0))
            
            XCTAssertEqual(updatedProduct?.packageDimensions?.length, Decimal(dimensions["length"]?.int ?? 0))
            
            XCTAssertEqual(updatedProduct?.packageDimensions?.weight, Decimal(dimensions["weight"]?.int ?? 0))
            
            XCTAssertEqual(updatedProduct?.packageDimensions?.width, Decimal(dimensions["width"]?.int ?? 0))
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
    
    func testDeleteProduct() throws {
        do {
            let deletedProduct = try drop?.stripe?.products.delete(product: productId).serializedResponse()
            
            XCTAssertNotNil(deletedProduct)
            
            XCTAssertTrue(deletedProduct?.deleted ?? false)
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
    
    func testListAllProducts() throws {
        do {
            let products = try drop?.stripe?.products.listAll(filter: nil).serializedResponse()
            
            XCTAssertNotNil(products)
            
            if let productItems = products?.items {
                XCTAssertGreaterThanOrEqual(productItems.count, 1)
            } else {
                XCTFail("Products are not present")
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
    
    func testFilterProducts() throws {
        do {
            let filter = StripeFilter()
            
            filter.limit = 1
            
            let products = try drop?.stripe?.products.listAll(filter: filter).serializedResponse()
            
            XCTAssertNotNil(products)
            
            if let productItems = products?.items {
                XCTAssertEqual(productItems.count, 1)
            } else {
                XCTFail("Products are not present")
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
