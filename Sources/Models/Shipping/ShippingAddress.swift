//
//  ShippingAddress.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor
import Helpers

/**
 Shipping Address
 https://stripe.com/docs/api/curl#charge_object-shipping-address
 */

public final class ShippingAddress: StripeModelProtocol {
    
    public var city: String?
    public var country: String?
    public var addressLine1: String?
    public var addressLine2: String?
    public var postalCode: String?
    public var state: String?
    
    public init() { }
    
    public init(node: Node) throws {
        self.city = try node.get("city")
        self.country = try node.get("country")
        self.addressLine1 = try node.get("line1")
        self.addressLine2 = try node.get("line2")
        self.postalCode = try node.get("postal_code")
        self.state = try node.get("state")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "city": self.city,
            "country": self.country,
            "line1": self.addressLine1,
            "line2": self.addressLine2,
            "postal_code": self.postalCode,
            "state": self.state
        ]
        return try Node(node: object)
    }
}
