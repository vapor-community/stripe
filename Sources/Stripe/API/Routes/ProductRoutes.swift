//
//  ProductRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Node
import HTTP

open class ProductRoutes {
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Create a product
     Creates a new product object.
     
     - parameter name:              The product’s name, meant to be displayable to the customer.
     - parameter id:                The identifier for the product. Must be unique. If not provided, 
                                    an identifier will be randomly generated.
     - parameter active:            Whether or not the product is currently available for purchase. 
                                    Defaults to true.
     - parameter attributes:        A list of up to 5 alphanumeric attributes that each SKU can provide 
                                    values for (e.g. ["color", "size"]).
     - parameter caption:           A short one-line description of the product, meant to be displayable 
                                    to the customer.
     - parameter deactivateOn:      An array of Connect application names or identifiers that should not 
                                    be able to order the SKUs for this product.
     - parameter description:       The product’s description, meant to be displayable to the customer.
     - parameter images:            A list of up to 8 URLs of images for this product, meant to be displayable 
                                    to the customer.
     - parameter packageDimensions: The dimensions of this product for shipping purposes. A SKU associated with 
                                    this product can override this value by having its own package_dimensions.
     - parameter shippable:         Whether this product is shipped (i.e. physical goods). Defaults to true.
     - parameter url:               A URL of a publicly-accessible webpage for this product.
     - parameter metadata:          A set of key/value pairs that you can attach to a product object. It can be 
                                    useful for storing additional information about the product in a structured format.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func create(name: String, id: String?, active: Bool? = nil, attributes: Node? = nil, caption: String? = nil, deactivateOn: Node? = nil, description: String? = nil, images: Node? = nil, packageDimensions: Node? = nil, shippable: Bool? = nil, url: String? = nil, metadata: Node? = nil) throws -> StripeRequest<Product> {
    
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
    
    /**
     Retrieve a product
     Retrieves the details of an existing product. Supply the unique product ID from either a product creation request or the product list, and Stripe will return the corresponding product information.
     
     - parameter productId: The identifier of the product to be retrieved.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func retrieve(product productId: String) throws -> StripeRequest<Product> {
        return try StripeRequest(client: self.client, method: .get, route: .products(productId), query: [:], body: nil, headers: nil)
    }
    
    /**
     Update a product
     Updates the specific product by setting the values of the parameters passed. Any parameters 
     not provided will be left unchanged.
     Note that a product’s attributes are not editable. Instead, you would need to deactivate the 
     existing product and create a new one with the new attribute values.
     
     - parameter productId:         The ID of the product to update
     - parameter active:            Whether or not the product is available for purchase.
     - parameter attributes:        A list of up to 5 alphanumeric attributes that each SKU can 
                                    provide values for (e.g. ["color", "size"]). If a value for attributes 
                                    is specified, the list specified will replace the existing attributes 
                                    list on this product. Any attributes not present after the update will 
                                    be deleted from the SKUs for this product. This will be unset if you 
                                    POST an empty value.
     - parameter caption:           A short one-line description of the product, meant to be displayable 
                                    to the customer.
     - parameter deactivateOn:      An array of Connect application names or identifiers that should not be 
                                    able to order the SKUs for this product. This will be unset if you POST 
                                    an empty value.
     - parameter description:       The product’s description, meant to be displayable to the customer.
     - parameter images:            A list of up to 8 URLs of images for this product, meant to be displayable 
                                    to the customer. This will be unset if you POST an empty value.
     - parameter name:              The product’s name, meant to be displayable to the customer.
     - parameter packageDimensions: The dimensions of this product for shipping purposes. A SKU associated with 
                                    this product can override this value by having its own package_dimensions.
     - parameter shippable:         Whether this product is shipped (i.e. physical goods). Defaults to true.
     - parameter url:               A URL of a publicly-accessible webpage for this product.
     - parameter metadata:          A set of key/value pairs that you can attach to a product object. It can be 
                                    useful for storing additional information about the product in a structured format. 
                                    You can unset individual keys if you POST an empty value for that key. 
                                    You can clear all keys if you POST an empty value for metadata.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func update(product productId: String, active: Bool? = nil, attributes: Node? = nil, caption: String? = nil, deactivateOn: Node? = nil, description: String? = nil, images: Node? = nil, name: String? = nil, packageDimensions: Node? = nil, shippable: Bool? = nil, url: String? = nil, metadata: Node? = nil) throws -> StripeRequest<Product> {
        
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
    
    /**
     List all products
     Returns a list of your products. The products are returned sorted by creation date, with the 
     most recently created products appearing first.
     
     - parameter filter: A Filter item to pass query parameters when fetching results
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func listAll(filter: StripeFilter? = nil) throws -> StripeRequest<ProductsList> {
        var query = [String : NodeRepresentable]()
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .product, query: query, body: nil, headers: nil)
    }
    
    /**
     Delete a product
     Delete a product. Deleting a product is only possible if it has no SKUs associated with it.
     
     - parameter productId: The ID of the product to delete.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func delete(product productId: String) throws -> StripeRequest<DeletedObject> {
        return try StripeRequest(client: self.client, method: .delete, route: .products(productId), query: [:], body: nil, headers: nil)
    }
}
