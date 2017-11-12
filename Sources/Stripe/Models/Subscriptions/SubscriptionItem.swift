//
//  SubscriptionItem.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/6/17.
//
//

import Foundation
import Vapor
/**
 SubscriptionItem Model
 https://stripe.com/docs/api/curl#subscription_items
 */
open class SubscriptionItem: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var created: Date?
    public private(set) var plan: Plan?
    public private(set) var quantity: Int?
    
    /**
     Deleted property
     https://stripe.com/docs/api/curl#delete_subscription_item
     */
    public private(set) var deleted: Bool?
    
    public required init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.created = try node.get("created")
        self.plan = try node.get("plan")
        self.quantity = try node.get("quantity")
        self.deleted = try node.get("deleted")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "created": self.created,
            "plan": self.plan,
            "quantity": self.quantity,
            "deleted": self.deleted
        ]
        return try Node(node: object)
    }
}
