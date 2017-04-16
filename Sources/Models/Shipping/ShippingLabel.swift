//
//  ShippingLabel.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor
import Helpers

/*
 Shipping
 https://stripe.com/docs/api/curl#charge_object-shipping
 */
public final class ShippingLabel: StripeModelProtocol {
    
    public let address: ShippingAddress
    public let carrier: String
    public let name: String
    public let phone: String
    public let trackingNumber: String
    
    public init(node: Node) throws {
        self.address = try node.get("address")
        self.carrier = try node.get("carrier")
        self.name = try node.get("name")
        self.phone = try node.get("phone")
        self.trackingNumber = try node.get("tracking_number")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            "address": self.address,
            "carrier": self.carrier,
            "name": self.name,
            "phone": self.phone,
            "tracking_number": self.trackingNumber,
        ])
    }
    
}
