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

class ProductTests: XCTestCase {
    let productString = """
    {
    "id": "prod_BosWT9EsdzgjPn",
    "object": "product",
    "active": false,
    "attributes": [
    "size",
    "gender"
    ],
    "caption": "test",
    "created": 1511420673,
    "deactivate_on": [
    
    ],
    "description": "Comfortable cotton t-shirt",
    "images": [
    
    ],
    "livemode": false,
    "metadata": {
    },
    "name": "T-shirt",
    "package_dimensions": {
    "height": 1.25,
    "length": 2.44,
    "weight": 3.0,
    "width": 4.0
    },
    "shippable": false,
    "skus": {
        "object": "list",
        "data": [
        {
        "id": "sku_C3rCQ7Eq4wRfLw",
        "object": "sku",
        "active": true,
        "attributes": {
        "size": "Medium",
        "gender": "Unisex"
        },
        "created": 1514875358,
        "currency": "usd",
        "image": null,
        "inventory": {
        "quantity": 500,
        "type": "finite",
        "value": null
        },
        "livemode": false,
        "metadata": {
        },
        "package_dimensions": null,
        "price": 1500,
        "product": "prod_BosWT9EsdzgjPn",
        "updated": 1514875358
        }
        ],
        "has_more": false,
        "total_count": 1,
        "url": "/v1/skus?product=prod_BosWT9EsdzgjPn&active=true"
        },
    "updated": 1511422435,
    "url": "https://api.stripe.com/"
    }
"""
    
    func testProductParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let body = HTTPBody(string: productString)
            let futureProduct = try decoder.decode(StripeProduct.self, from: body)
            
            futureProduct.do { (product) in
                XCTAssertEqual(product.id, "prod_BosWT9EsdzgjPn")
                XCTAssertEqual(product.object, "product")
                XCTAssertEqual(product.active, false)
                XCTAssertEqual(product.attributes, ["size", "gender"])
                XCTAssertEqual(product.caption, "test")
                XCTAssertEqual(product.created, Date(timeIntervalSince1970: 1511420673))
                XCTAssertEqual(product.deactivateOn, [])
                XCTAssertEqual(product.description, "Comfortable cotton t-shirt")
                XCTAssertEqual(product.images, [])
                XCTAssertEqual(product.livemode, false)
                XCTAssertEqual(product.metadata, [:])
                XCTAssertEqual(product.name, "T-shirt")
                XCTAssertEqual(product.packageDimensions?.height, 1.25)
                XCTAssertEqual(product.packageDimensions?.length, 2.44)
                XCTAssertEqual(product.packageDimensions?.weight, 3.0)
                XCTAssertEqual(product.packageDimensions?.width, 4.0)
                XCTAssertEqual(product.shippable, false)
                XCTAssertEqual(product.updated, Date(timeIntervalSince1970: 1511422435))
                XCTAssertEqual(product.url, "https://api.stripe.com/")
                XCTAssertEqual(product.skus?.object, "list")
                XCTAssertEqual(product.skus?.hasMore, false)
                XCTAssertEqual(product.skus?.totalCount, 1)
                XCTAssertEqual(product.skus?.url, "/v1/skus?product=prod_BosWT9EsdzgjPn&active=true")
                XCTAssertNotNil(product.skus?.data?[0])
                
                }.catch { (error) in
                    XCTFail("\(error)")
            }
        }
        catch {
            XCTFail("\(error)")
        }
    }
}
