//
//  ProductRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Vapor

public protocol ProductRoutes {
    associatedtype PR: Product
    associatedtype DO: DeletedObject
    associatedtype L: List
    associatedtype PD: PackageDimensions
    
    func create(id: String?, name: String, active: Bool?, attributes: [String]?, caption: String?, deactivateOn: [String]?, description: String?, images: [String]?, metadata: [String: String]?, packageDimensions: PD?, shippable: Bool?, url: String?) throws -> Future<PR>
    func retrieve(id: String) throws -> Future<PR>
    func update(product: String, active: Bool?, attributes: [String]?, caption: String?, deactivateOn: [String]?, description: String?, images: [String]?, metadata: [String: String]?, name: String?, packageDimensions: PD?, shippable: Bool?, url: String?) throws -> Future<PR>
    func listAll(filter: [String: Any]?) throws -> Future<L>
    func delete(id: String) throws -> Future<DO>
}

public struct StripeProductRoutes<SR: StripeRequest>: ProductRoutes {
    private let request: SR
    
    init(request: SR) {
        self.request = request
    }

    /// Create a product
    /// [Learn More →](https://stripe.com/docs/api/curl#create_product)
    public func create(id: String? = nil,
                       name: String,
                       active: Bool? = nil,
                       attributes: [String]? = nil,
                       caption: String? = nil,
                       deactivateOn: [String]? = nil,
                       description: String? = nil,
                       images: [String]? = nil,
                       metadata: [String : String]? = nil,
                       packageDimensions: StripePackageDimensions? = nil,
                       shippable: Bool? = nil,
                       url: String? = nil) throws -> Future<StripeProduct> {
        var body: [String: Any] = [:]
        
        body["name"] = name

        if let id = id {
            body["id"] = id
        }

        if let active = active {
            body["active"] = active
        }
        
        if let attributes = attributes {
            for i in 0..<attributes.count {
                body["attributes[\(i)]"] = attributes[i]
            }
        }
        
        if let caption = caption {
            body["caption"] = caption
        }
        
        if let deactivateOn = deactivateOn {
            for i in 0..<deactivateOn.count {
                body["deactivate_on[\(i)]"] = deactivateOn[i]
            }
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let images = images {
            for i in 0..<images.count {
                body["images[\(i)]"] = images[i]
            }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let packageDimensions = packageDimensions {
            try packageDimensions.toEncodedDictionary().forEach { body["package_dimensions[\($0)]"] = $1 }
        }
        
        if let shippable = shippable {
            body["shippable"] = shippable
        }
        
        if let url = url {
            body["url"] = url
        }
        
        return try request.send(method: .post, path: StripeAPIEndpoint.product.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve a product
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_product)
    public func retrieve(id: String) throws -> Future<StripeProduct> {
        return try request.send(method: .get, path: StripeAPIEndpoint.products(id).endpoint)
    }
    
    /// Update a product
    /// [Learn More →](https://stripe.com/docs/api/curl#update_product)
    public func update(product: String,
                       active: Bool? = nil,
                       attributes: [String]? = nil,
                       caption: String? = nil,
                       deactivateOn: [String]? = nil,
                       description: String? = nil,
                       images: [String]? = nil,
                       metadata: [String : String]? = nil,
                       name: String? = nil,
                       packageDimensions: StripePackageDimensions? = nil,
                       shippable: Bool? = nil,
                       url: String? = nil) throws -> Future<StripeProduct> {
        var body: [String: Any] = [:]
        
        if let active = active {
            body["active"] = active
        }
        
        if let attributes = attributes {
            for i in 0..<attributes.count {
                body["attributes[\(i)]"] = attributes[i]
            }
        }
        
        if let caption = caption {
            body["caption"] = caption
        }
        
        if let deactivateOn = deactivateOn {
            for i in 0..<deactivateOn.count {
                body["deactivate_on[\(i)]"] = deactivateOn[i]
            }
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let images = images {
            for i in 0..<images.count {
                body["images[\(i)]"] = images[i]
            }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let name = name {
            body["name"] = name
        }
        
        if let packageDimensions = packageDimensions {
            try packageDimensions.toEncodedDictionary().forEach { body["package_dimensions[\($0)]"] = $1 }
        }
        
        if let shippable = shippable {
            body["shippable"] = shippable
        }
        
        if let url = url {
            body["url"] = url
        }

        return try request.send(method: .post, path: StripeAPIEndpoint.products(product).endpoint, body: body.queryParameters)
    }
    
    /// List all products
    /// [Learn More →](https://stripe.com/docs/api/curl#list_products)
    public func listAll(filter: [String : Any]? = nil) throws -> Future<ProductsList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .get, path: StripeAPIEndpoint.product.endpoint, query: queryParams)
    }
    
    /// Delete a product
    /// [Learn More →](https://stripe.com/docs/api/curl#delete_product)
    public func delete(id: String) throws -> Future<StripeDeletedObject> {
        return try request.send(method: .delete, path: StripeAPIEndpoint.products(id).endpoint)
    }
}
