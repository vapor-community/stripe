//
//  ShippingMethod.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation
import Vapor


public final class ShippingMethod: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var amount: Int?
    public private(set) var currency: StripeCurrency?
    public private(set) var deliveryEstimate: DeliveryEstimate?
    public private(set) var description: String?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.amount = try node.get("amount")
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        self.deliveryEstimate = try node.get("delivery_estimate")
        self.description = try node.get("description")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        
        let object: [String: Any?] = [
            "id": self.id,
            "amount": self.amount,
            "currency": self.currency?.rawValue,
            "delivery_estimate": self.deliveryEstimate,
            "description": self.description,
        ]
        return try Node(node: object)
    }
}
