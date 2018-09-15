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
    let skuString = """
{
  "id": "sku_CG2zw7j7H8NEQq",
  "object": "sku",
  "active": true,
  "attributes": {
    "size": "Medium",
    "gender": "Unisex"
  },
  "created": 1517686889,
  "currency": "usd",
  "image": "https://www.example.com",
  "inventory": {
    "quantity": 499,
    "type": "finite",
    "value": "in_stock" },
  "metadata": {
    "hello": "world"
  },
  "package_dimensions": {
    "height": 12.3,
    "length": 13.3,
    "weight": 14.3,
    "width": 15.3
  },
  "price": 1500,
  "livemode": false,
  "product": "prod_BosWT9EsdzgjPn",
  "updated": 1517686906
}
"""
    
    func testSkuParsedProperly() throws {
        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .secondsSince1970
            
            let body = HTTPBody(string: skuString)
            var headers: HTTPHeaders = [:]
            headers.replaceOrAdd(name: .contentType, value: MediaType.json.description)
            let request = HTTPRequest(headers: headers, body: body)
            let futureSku = try decoder.decode(StripeSKU.self, from: request, maxSize: 65_536, on: EmbeddedEventLoop())
            
            futureSku.do { (sku) in
                XCTAssertEqual(sku.id, "sku_CG2zw7j7H8NEQq")
                XCTAssertEqual(sku.object, "sku")
                XCTAssertEqual(sku.active, true)
                XCTAssertEqual(sku.attributes?["size"], "Medium")
                XCTAssertEqual(sku.attributes?["gender"], "Unisex")
                XCTAssertEqual(sku.created, Date(timeIntervalSince1970: 1517686889))
                XCTAssertEqual(sku.currency, .usd)
                XCTAssertEqual(sku.image, "https://www.example.com")
                XCTAssertEqual(sku.livemode, false)
                XCTAssertEqual(sku.metadata["hello"], "world")
                XCTAssertEqual(sku.price, 1500)
                XCTAssertEqual(sku.product, "prod_BosWT9EsdzgjPn")
                XCTAssertEqual(sku.updated, Date(timeIntervalSince1970: 1517686906))
                
                XCTAssertEqual(sku.packageDimensions?.height, 12.3)
                XCTAssertEqual(sku.packageDimensions?.length, 13.3)
                XCTAssertEqual(sku.packageDimensions?.weight, 14.3)
                XCTAssertEqual(sku.packageDimensions?.width, 15.3)
                
                XCTAssertEqual(sku.inventory?.quantity, 499)
                XCTAssertEqual(sku.inventory?.type, .finite)
                XCTAssertEqual(sku.inventory?.value, .inStock)
                
                }.catch { (error) in
                    XCTFail("\(error.localizedDescription)")
            }
        }
        catch {
            XCTFail("\(error.localizedDescription)")
        }
    }
}
