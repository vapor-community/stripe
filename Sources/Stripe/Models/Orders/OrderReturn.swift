//
//  OrderReturn.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation
import Vapor


/**
 OrderReturn object
 https://stripe.com/docs/api#order_return_object
 */

open class OrderReturn: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var amount: Int?
    public private(set) var created: Date?
    public private(set) var currency: StripeCurrency?
    public private(set) var items: [OrderItem]?
    public private(set) var isLive: Bool?
    public private(set) var order: String?
    public private(set) var refund: String?
    
    public required init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.amount = try node.get("amount")
        self.created = try node.get("created")
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        self.items = try node.get("items")
        self.isLive = try node.get("livemode")
        self.order = try node.get("order")
        self.refund = try node.get("refund")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        
        let object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "amount": self.amount,
            "created": self.created,
            "currency": self.currency?.rawValue,
            "items": self.items,
            "livemode": self.isLive,
            "order": self.order,
            "refund": self.refund,
        ]
        return try Node(node: object)
    }
}
