//
//  SKU.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Foundation
import Vapor

/**
 SKU object
 https://stripe.com/docs/api#skus
 */

open class SKU: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var active: Bool?
    public private(set) var attributes: Node?
    public private(set) var created: Date?
    public private(set) var currency: StripeCurrency?
    public private(set) var image: String?
    public private(set) var inventory: Inventory?
    public private(set) var isLive: Bool?
    public private(set) var metadata: Node?
    public private(set) var packageDimensions: PackageDimensions?
    public private(set) var price: Int?
    public private(set) var product: String?
    public private(set) var updated: Date?
    
    public required init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.active = try node.get("active")
        self.attributes = try node.get("attributes")
        self.created = try node.get("created")
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        self.image = try node.get("image")
        self.inventory = try node.get("inventory")
        self.isLive = try node.get("livemode")
        self.metadata = try node.get("metadata")
        self.packageDimensions = try node.get("package_dimensions")
        self.price = try node.get("price")
        self.product = try node.get("product")
        self.updated = try node.get("updated")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        
        let object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "active": self.active,
            "attributes": self.attributes,
            "created": self.created,
            "currency": self.currency?.rawValue,
            "image": self.image,
            "inventory": self.inventory,
            "livemode": self.isLive,
            "metadata": self.metadata,
            "package_dimensions": self.packageDimensions,
            "price": self.price,
            "product": self.product,
            "updated": self.updated
        ]
        return try Node(node: object)
    }
}
