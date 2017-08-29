//
//  SKURoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Foundation
import Node


import HTTP

public final class SKURoutes {
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    public func create(currency: StripeCurrency, inventory: Node, price: Int, product: String, id: String?, active: Bool?, attributes: Node?, image: String?, packageDimensions: Node?, metadata: Node? = nil) throws -> StripeRequest<SKU> {
        var body = Node([:])
        
        body["currency"] = Node(currency.rawValue)
        
        if let inventory = inventory.object {
            for (key,value) in inventory {
                body["inventory[\(key)]"] = value
            }
        }
        
        body["price"] = Node(price)
        
        body["product"] = Node(product)
        
        if let active = active {
            body["active"] = Node(active)
        }
        
        if let attributes = attributes?.object {
            for (key,value) in attributes {
                body["attributes[\(key)]"] = value
            }
        }
        
        if let image = image {
            body["image"] = Node(image)
        }
        
        if let packagedimensions = packageDimensions?.object {
            for (key,value) in packagedimensions {
                body["package_dimensions[\(key)]"] = value
            }
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .sku, query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    public func retrieve(sku skuId: String) throws -> StripeRequest<SKU> {
        return try StripeRequest(client: self.client, method: .get, route: .skus(skuId), query: [:], body: nil, headers: nil)
    }
    
    public func update(sku skuId: String, active: Bool?, attributes: Node?, currency: StripeCurrency?, image: String?, inventory: Node?, packageDimensions: Node?, price: Int?, product: String?, metadata: Node? = nil) throws -> StripeRequest<SKU> {
        var body = Node([:])
        
        
        if let active = active {
            body["active"] = Node(active)
        }
        
        if let attributes = attributes?.object {
            for (key,value) in attributes {
                body["attributes[\(key)]"] = value
            }
        }
        
        if let currency = currency {
            body["currency"] = Node(currency.rawValue)
        }
        
        if let image = image {
            body["image"] = Node(image)
        }
        
        if let inventory = inventory?.object {
            for (key,value) in inventory {
                body["inventory[\(key)]"] = value
            }
        }
    
        if let packagedimensions = packageDimensions?.object {
            for (key,value) in packagedimensions {
                body["package_dimensions[\(key)]"] = value
            }
        }
        if let price = price {
            body["price"] = Node(price)
        }
        
        if let product = product {
            body["product"] = Node(product)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .skus(skuId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    public func listAll(filter: StripeFilter? = nil) throws -> StripeRequest<SKUList> {
     var query = [String : NodeRepresentable]()
     if let data = try filter?.createQuery() {
     query = data
     }
     return try StripeRequest(client: self.client, method: .get, route: .sku, query: query, body: nil, headers: nil)
     }
    
    public func delete(sku skuId: String) throws -> StripeRequest<DeletedObject> {
        return try StripeRequest(client: self.client, method: .delete, route: .skus(skuId), query: [:], body: nil, headers: nil)
    }
}
