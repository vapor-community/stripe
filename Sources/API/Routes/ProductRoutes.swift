//
//  ProductRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Foundation
import Node
import Models
import Helpers
import HTTP

public final class ProductRoutes {
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    public func create(name: String, id: String?, active: Bool?, attributes: Node?, caption: String?, deactivateOn: Node?, description: String?, images: Node?, packageDimensions: Node?, shippable: Bool?, url: String?, metadata: Node? = nil) throws -> StripeRequest<Product> {
    
        var body = Node([:])
        
        body["name"] = Node(name)
        
        if let id = id {
            body["id"] = Node(id)
        }
        
        if let active = active {
            body["active"] = Node(active)
        }
        
        if let attributes = attributes?.array {
            body["attributes"] = Node(attributes)
        }
        
        if let caption = caption {
            body["caption"] = Node(caption)
        }
        
        if let deactivateOn = deactivateOn?.array {
            body["deactivate_on"] = Node(deactivateOn)
        }
        
        if let description = description {
            body["description"] = Node(description)
        }
        
        if let images = images?.array {
            body["images"] = Node(images)
        }
        
        if let packagedimensions = packageDimensions?.object {
            for (key,value) in packagedimensions {
                body["package_dimensions[\(key)]"] = value
            }
        }
        
        if let shippable = shippable {
            body["shippable"] = Node(shippable)
        }
        
        if let url = url {
            body["url"] = Node(url)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .product, query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    public func retrieve(product productId: String) throws -> StripeRequest<Product> {
        return try StripeRequest(client: self.client, method: .get, route: .products(productId), query: [:], body: nil, headers: nil)
    }
    
    public func update(product productId: String, active: Bool?, attributes: Node?, caption: String?, deactivateOn: Node?, description: String?, images: Node?, name: String?, packageDimensions: Node?, shippable: Bool?, url: String?, metadata: Node? = nil) throws -> StripeRequest<Product> {
        
        var body = Node([:])

        if let name = name {
            body["name"] = Node(name)
        }
        
        if let active = active {
            body["active"] = Node(active)
        }
        
        if let attributes = attributes?.array {
            body["attributes"] = Node(attributes)
        }
        
        if let caption = caption {
            body["caption"] = Node(caption)
        }
        
        if let deactivateOn = deactivateOn?.array {
            body["deactivate_on"] = Node(deactivateOn)
        }
        
        if let description = description {
            body["description"] = Node(description)
        }
        
        if let images = images?.array {
            body["images"] = Node(images)
        }
        
        if let packagedimensions = packageDimensions?.object {
            for (key,value) in packagedimensions {
                body["package_dimensions[\(key)]"] = value
            }
        }
        
        if let shippable = shippable {
            body["shippable"] = Node(shippable)
        }
        
        if let url = url {
            body["url"] = Node(url)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .products(productId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    public func listAll(filter: StripeFilter? = nil) throws -> StripeRequest<ProductsList> {
        var query = [String : NodeRepresentable]()
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .product, query: query, body: nil, headers: nil)
    }
    
    public func delete(product productId: String) throws -> StripeRequest<DeletedObject> {
        return try StripeRequest(client: self.client, method: .delete, route: .products(productId), query: [:], body: nil, headers: nil)
    }
}
