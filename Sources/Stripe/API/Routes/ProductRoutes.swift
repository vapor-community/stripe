//
//  ProductRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Vapor

public protocol ProductRoutes {
    func create(id: String?, name: String, type: String, active: Bool?, attributes: [String]?, caption: String?, deactivateOn: [String]?, description: String?, images: [String]?, metadata: [String: String]?, packageDimensions: StripePackageDimensions?, shippable: Bool?, statementDescriptor: String?, url: String?) throws -> Future<StripeProduct>
    func retrieve(id: String) throws -> Future<StripeProduct>
    func update(product: String, active: Bool?, attributes: [String]?, caption: String?, deactivateOn: [String]?, description: String?, images: [String]?, metadata: [String: String]?, name: String?, packageDimensions: StripePackageDimensions?, shippable: Bool?, statementDescriptor: String?, url: String?) throws -> Future<StripeProduct>
    func listAll(filter: [String: Any]?) throws -> Future<ProductsList>
    func delete(id: String) throws -> Future<StripeDeletedObject>
}

public struct StripeProductRoutes: ProductRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }

    /// Create a product
    /// [Learn More →](https://stripe.com/docs/api/curl#create_product)
    public func create(id: String? = nil,
                       name: String,
                       type: String,
                       active: Bool? = nil,
                       attributes: [String]? = nil,
                       caption: String? = nil,
                       deactivateOn: [String]? = nil,
                       description: String? = nil,
                       images: [String]? = nil,
                       metadata: [String : String]? = nil,
                       packageDimensions: StripePackageDimensions? = nil,
                       shippable: Bool? = nil,
                       statementDescriptor: String? = nil,
                       url: String? = nil) throws -> Future<StripeProduct> {
        var body: [String: Any] = [:]
        
        body["name"] = name
        
        body["type"] = type

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

        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let url = url {
            body["url"] = url
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.product.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve a product
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_product)
    public func retrieve(id: String) throws -> Future<StripeProduct> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.products(id).endpoint)
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
                       statementDescriptor: String? = nil,
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
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let url = url {
            body["url"] = url
        }

        return try request.send(method: .POST, path: StripeAPIEndpoint.products(product).endpoint, body: body.queryParameters)
    }
    
    /// List all products
    /// [Learn More →](https://stripe.com/docs/api/curl#list_products)
    public func listAll(filter: [String : Any]? = nil) throws -> Future<ProductsList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .GET, path: StripeAPIEndpoint.product.endpoint, query: queryParams)
    }
    
    /// Delete a product
    /// [Learn More →](https://stripe.com/docs/api/curl#delete_product)
    public func delete(id: String) throws -> Future<StripeDeletedObject> {
        return try request.send(method: .DELETE, path: StripeAPIEndpoint.products(id).endpoint)
    }
}
