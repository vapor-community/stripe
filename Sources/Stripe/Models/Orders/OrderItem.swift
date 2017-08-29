//
//  OrderItem.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation
import Vapor


/**
 OrderItem object
 https://stripe.com/docs/api#order_item_object-object
 */

public final class OrderItem: StripeModelProtocol {
    
    public private(set) var object: String?
    public private(set) var amount: Int?
    public private(set) var currency: StripeCurrency?
    public private(set) var description: String?
    public private(set) var parent: String?
    public private(set) var quantity: Int?
    public private(set) var type: OrderItemType?
    
    public init(node: Node) throws {
        self.object = try node.get("object")
        self.amount = try node.get("amount")
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        self.description = try node.get("description")
        self.parent = try node.get("parent")
        self.quantity = try node.get("quantity")
        if let type = node["type"]?.string {
            self.type = OrderItemType(rawValue: type)
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        
        let object: [String: Any?] = [
            "object": self.object,
            "amount": self.amount,
            "currency": self.currency?.rawValue,
            "description": self.description,
            "parent": self.parent,
            "quantity": self.quantity,
            "type": self.type
        ]
        return try Node(node: object)
    }
}
