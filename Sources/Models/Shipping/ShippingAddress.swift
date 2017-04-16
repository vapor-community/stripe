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

/*
 Shipping Address
 https://stripe.com/docs/api/curl#charge_object-shipping-address
 */

public final class ShippingAddress: StripeModelProtocol {
    
    public let city: String
    public let country: String
    public let addressLine1: String
    public let addressLine2: String
    public let postalCode: String
    public let state: String
    
    public init(node: Node) throws {
        self.city = try node.get("city")
        self.country = try node.get("country")
        self.addressLine1 = try node.get("line1")
        self.addressLine2 = try node.get("line2")
        self.postalCode = try node.get("postal_code")
        self.state = try node.get("state")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            "city": self.city,
            "country": self.country,
            "line1": self.addressLine1,
            "line2": self.addressLine2,
            "postal_code": self.postalCode,
            "state": self.state
        ])
    }
    
}
