//
//  Products.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Foundation
import Vapor

/**
 Product object
 https://stripe.com/docs/api#products
 */

open class Product: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var active: Bool?
    public private(set) var attributes: Node?
    public private(set) var caption: String?
    public private(set) var created: Date?
    public private(set) var deactivateOn: Node?
    public private(set) var description: String?
    public private(set) var images: Node?
    public private(set) var isLive: Bool?
    public private(set) var metadata: Node?
    public private(set) var name: String?
    public private(set) var packageDimensions: PackageDimensions?
    public private(set) var shippable: Bool?
    public private(set) var skus: SKUList?
    public private(set) var updated: Date?
    public private(set) var url: String?
    
    public required init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.active = try node.get("active")
        self.attributes = try node.get("attributes")
        self.caption = try node.get("caption")
        self.created = try node.get("created")
        self.deactivateOn = try node.get("deactivate_on")
        self.description = try node.get("description")
        self.images = try node.get("images")
        self.isLive = try node.get("livemode")
        self.metadata = try node.get("metadata")
        self.name = try node.get("name")
        self.packageDimensions = try node.get("package_dimensions")
        self.shippable = try node.get("shippable")
        self.skus = try node.get("skus")
        self.updated = try node.get("updated")
        self.url = try node.get("url")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        
        let object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "active": self.active,
            "attributes": self.attributes,
            "caption": self.caption,
            "created": self.created,
            "deactivate_on": self.deactivateOn,
            "description": self.description,
            "images": self.images,
            "livemode": self.isLive,
            "name": self.name,
            "metadata": self.metadata,
            "package_dimensions": self.packageDimensions,
            "shippable": self.shippable,
            "skus": self.skus,
            "updated": self.updated,
            "url": self.url
        ]
        return try Node(node: object)
    }
}
