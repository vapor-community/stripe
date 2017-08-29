//
//  ShippingLabel.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor


/**
 Shipping
 https://stripe.com/docs/api/curl#charge_object-shipping
 */
public final class ShippingLabel: StripeModelProtocol {
    
    public var address: ShippingAddress?
    public var carrier: String?
    public var name: String?
    public var phone: String?
    public var trackingNumber: String?
    
    public init() { }
    
    public init(node: Node) throws {
        self.address = try node.get("address")
        self.carrier = try node.get("carrier")
        self.name = try node.get("name")
        self.phone = try node.get("phone")
        self.trackingNumber = try node.get("tracking_number")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "address": self.address,
            "carrier": self.carrier,
            "name": self.name,
            "phone": self.phone,
            "tracking_number": self.trackingNumber,
        ]
        return try Node(node: object)
    }
}
