//
//  SKURoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

//import Node
//import HTTP
//
//open class SKURoutes {
//    let client: StripeClient
//    
//    init(client: StripeClient) {
//        self.client = client
//    }
//    
//    /**
//     Create a SKU
//     Creates a new SKU associated with a product.
//     
//     - parameter currency:          Three-letter ISO currency code, in lowercase.
//     - parameter inventory:         Description of the SKU’s inventory.
//     - parameter price:             The cost of the item as a nonnegative integer in the smallest 
//                                    currency unit (that is, 100 cents to charge $1.00, or 100 to 
//                                    charge ¥100, Japanese Yen being a zero-decimal currency).
//     - parameter product:           The ID of the product this SKU is associated with.
//     - parameter id:                The ID of the product this SKU is associated with.
//     - parameter active:            Whether or not the SKU is available for purchase. Default to true.
//     - parameter attributes:        A dictionary of attributes and values for the attributes defined by 
//                                    the product. If, for example, a product’s attributes are ["size", "gender"], 
//                                    a valid SKU has the following dictionary of attributes: 
//                                    {"size": "Medium", "gender": "Unisex"}.
//     - parameter image:             The URL of an image for this SKU, meant to be displayable to the customer.
//     - parameter packageDimensions: The dimensions of this SKU for shipping purposes.
//     - parameter metadata:          A set of key/value pairs that you can attach to a SKU object. It can be 
//                                    useful for storing additional information about the SKU in a structured format.
//     
//     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
//     */
//    public func create(currency: StripeCurrency, inventory: Node, price: Int, product: String, id: String? = nil, active: Bool? = nil, attributes: Node? = nil, image: String? = nil, packageDimensions: Node? = nil, metadata: Node? = nil) throws -> StripeRequest<SKU> {
//        var body = Node([:])
//        
//        body["currency"] = Node(currency.rawValue)
//        
//        if let inventory = inventory.object {
//            for (key,value) in inventory {
//                body["inventory[\(key)]"] = value
//            }
//        }
//        
//        body["price"] = Node(price)
//        
//        body["product"] = Node(product)
//        
//        if let active = active {
//            body["active"] = Node(active)
//        }
//        
//        if let attributes = attributes?.object {
//            for (key,value) in attributes {
//                body["attributes[\(key)]"] = value
//            }
//        }
//        
//        if let image = image {
//            body["image"] = Node(image)
//        }
//        
//        if let packagedimensions = packageDimensions?.object {
//            for (key,value) in packagedimensions {
//                body["package_dimensions[\(key)]"] = value
//            }
//        }
//        
//        if let metadata = metadata?.object {
//            for (key, value) in metadata {
//                body["metadata[\(key)]"] = value
//            }
//        }
//        
//        return try StripeRequest(client: self.client, method: .post, route: .sku, query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
//    }
//    
//    /**
//     Retrieve a SKU
//     Retrieves the details of an existing SKU. Supply the unique SKU identifier from either a SKU 
//     creation request or from the product, and Stripe will return the corresponding SKU information.
//     
//     - parameter skuId: The identifier of the SKU to be retrieved.
//     
//     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
//     */
//    public func retrieve(sku skuId: String) throws -> StripeRequest<SKU> {
//        return try StripeRequest(client: self.client, method: .get, route: .skus(skuId), query: [:], body: nil, headers: nil)
//    }
//    
//    /**
//     Update a SKU
//     Updates the specific SKU by setting the values of the parameters passed. Any parameters not 
//     provided will be left unchanged.
//     Note that a SKU’s attributes are not editable. Instead, you would need to deactivate the 
//     existing SKU and create a new one with the new attribute values.
//     
//     - parameter skuId:             The identifier of the SKU to be updated.
//     - parameter active:            Whether or not this SKU is available for purchase.
//     - parameter attributes:        A dictionary of attributes and values for the attributes 
//                                    defined by the product. When specified, attributes will 
//                                    partially update the existing attributes dictionary on the 
//                                    product, with the postcondition that a value must be present 
//                                    for each attribute key on the product, and that all SKUs for 
//                                    the product must have unique sets of attributes.
//     - parameter currency:          hree-letter ISO currency code, in lowercase.
//     - parameter image:             The URL of an image for this SKU, meant to be displayable to 
//                                    the customer. This will be unset if you POST an empty value.
//     - parameter inventory:         Description of the SKU’s inventory.
//     - parameter packageDimensions: The dimensions of this SKU for shipping purposes.
//     - parameter price:             The cost of the item as a positive integer in the smallest 
//                                    currency unit (that is, 100 cents to charge $1.00, or 100 
//                                    to charge ¥100, Japanese Yen being a zero-decimal currency).
//     - parameter product:           The ID of the product that this SKU should belong to. The 
//                                    product must exist and have the same set of attribute names 
//                                    as the SKU’s current product.
//     - parameter metadata:          A set of key/value pairs that you can attach to a SKU object. 
//                                    It can be useful for storing additional information about the 
//                                    SKU in a structured format. You can unset individual keys if 
//                                    you POST an empty value for that key. You can clear all keys 
//                                    if you POST an empty value for metadata.
//     
//     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
//     */
//    public func update(sku skuId: String, active: Bool? = nil, attributes: Node? = nil, currency: StripeCurrency? = nil, image: String? = nil, inventory: Node? = nil, packageDimensions: Node? = nil, price: Int? = nil, product: String? = nil, metadata: Node? = nil) throws -> StripeRequest<SKU> {
//        var body = Node([:])
//        
//        
//        if let active = active {
//            body["active"] = Node(active)
//        }
//        
//        if let attributes = attributes?.object {
//            for (key,value) in attributes {
//                body["attributes[\(key)]"] = value
//            }
//        }
//        
//        if let currency = currency {
//            body["currency"] = Node(currency.rawValue)
//        }
//        
//        if let image = image {
//            body["image"] = Node(image)
//        }
//        
//        if let inventory = inventory?.object {
//            for (key,value) in inventory {
//                body["inventory[\(key)]"] = value
//            }
//        }
//    
//        if let packagedimensions = packageDimensions?.object {
//            for (key,value) in packagedimensions {
//                body["package_dimensions[\(key)]"] = value
//            }
//        }
//        if let price = price {
//            body["price"] = Node(price)
//        }
//        
//        if let product = product {
//            body["product"] = Node(product)
//        }
//        
//        if let metadata = metadata?.object {
//            for (key, value) in metadata {
//                body["metadata[\(key)]"] = value
//            }
//        }
//        
//        return try StripeRequest(client: self.client, method: .post, route: .skus(skuId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
//    }
//    
//    /**
//     List all SKUs
//     Returns a list of your SKUs. The SKUs are returned sorted by creation date, with the most 
//     recently created SKUs appearing first.
//     
//     - parameter filter: A Filter item to pass query parameters when fetching results
//     
//     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
//     */
//    public func listAll(filter: StripeFilter? = nil) throws -> StripeRequest<SKUList> {
//     var query = [String : NodeRepresentable]()
//     if let data = try filter?.createQuery() {
//     query = data
//     }
//     return try StripeRequest(client: self.client, method: .get, route: .sku, query: query, body: nil, headers: nil)
//     }
//    
//    /**
//     Delete a SKU
//     Delete a SKU. Deleting a SKU is only possible until it has been used in an order.
//     
//     - parameter skuId: The identifier of the SKU to be deleted.
//     
//     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
//     */
//    public func delete(sku skuId: String) throws -> StripeRequest<DeletedObject> {
//        return try StripeRequest(client: self.client, method: .delete, route: .skus(skuId), query: [:], body: nil, headers: nil)
//    }
//}

