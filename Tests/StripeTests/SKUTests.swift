//
//  SKUTests.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import XCTest

@testable import Stripe
@testable import Vapor





class SKUTests: XCTestCase {
    
    var drop: Droplet?
    var skuId: String = ""
    
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
                                                            shippable: nil,
                                                            url: nil)
                                                            .serializedResponse().id ?? ""
            
            let inventory = try Node(node:[
                    "quantity":55,
                    "type":InventoryType.finite.rawValue,])
            
            
            let attributes = try Node(node:["size": "xl"])
            
            skuId = try drop?.stripe?.skus.create(currency: .usd,
                                                  inventory: inventory,
                                                  price: 2500,
                                                  product: productId,
                                                  id: nil,
                                                  active: nil,
                                                  attributes: attributes,
                                                  image: nil,
                                                  packageDimensions: nil)
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
        skuId = ""
    }
    
    func testRetrieveSKU() throws {
        do {
            let sku = try drop?.stripe?.skus.retrieve(sku: skuId)
            
            XCTAssertNotNil(sku)
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
    
    func testUpdateSKU() throws {
        do {
            let metadata = try Node(node:["hello":"world"])
            let attributes = try Node(node:["size":"xxl"])
            let inventory = try Node(node:[
                "quantity":54,
                "type":InventoryType.finite.rawValue,])
            let packageDimenson = try Node(node: [
                "height": 12,
                "length": 22,
                "weight": 92,
                "width": 33])
            let price = 2200
            
            
            let updatedSKU = try drop?.stripe?.skus.update(sku: skuId,
                                                            active: nil,
                                                            attributes: attributes,
                                                            currency: nil,
                                                            image: nil,
                                                            inventory: inventory,
                                                            packageDimensions: packageDimenson,
                                                            price: price,
                                                            product: nil,
                                                            metadata: metadata)
                                                            .serializedResponse()
            
            XCTAssertNotNil(updatedSKU)
            
            XCTAssertEqual(updatedSKU?.metadata?["hello"], metadata["hello"])
            
            XCTAssertEqual(updatedSKU?.attributes?["size"], attributes["size"])
            
            XCTAssertEqual(updatedSKU?.inventory?.quantity, inventory["quantity"]?.int)
            
            XCTAssertEqual(updatedSKU?.inventory?.type, InventoryType.finite)
            
            XCTAssertEqual(updatedSKU?.inventory?.value, nil)
            
            XCTAssertEqual(updatedSKU?.packageDimensions?.height, Decimal(packageDimenson["height"]?.int ?? 0))
            
            XCTAssertEqual(updatedSKU?.packageDimensions?.length, Decimal(packageDimenson["length"]?.int ?? 0))
            
            XCTAssertEqual(updatedSKU?.packageDimensions?.weight, Decimal(packageDimenson["weight"]?.int ?? 0))
            
            XCTAssertEqual(updatedSKU?.packageDimensions?.width, Decimal(packageDimenson["width"]?.int ?? 0))
            
            XCTAssertEqual(updatedSKU?.price, price)
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
    
    func testDeleteSKU() throws {
        do {
            let deletedSKU = try drop?.stripe?.skus.delete(sku: skuId).serializedResponse()
            
            XCTAssertNotNil(deletedSKU)
            
            XCTAssertTrue(deletedSKU?.deleted ?? false)
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
    
    func testListAllSKUs() throws {
        do {
            let skus = try drop?.stripe?.skus.listAll(filter: nil).serializedResponse()
            
            XCTAssertNotNil(skus)
            
            if let skuItems = skus?.items {
                XCTAssertGreaterThanOrEqual(skuItems.count, 1)
            } else {
                XCTFail("SKUs are not present")
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
    
    func testFilterSKUs() throws {
        do {
            let filter = StripeFilter()
            
            filter.limit = 1
            
            let skus = try drop?.stripe?.skus.listAll(filter: filter).serializedResponse()
            
            XCTAssertNotNil(skus)
            
            if let skuItems = skus?.items {
                XCTAssertEqual(skuItems.count, 1)
            } else {
                XCTFail("SKUs are not present")
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
