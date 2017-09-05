//
//  InvoiceItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/5/17.
//
//

import Foundation
import Vapor

public final class InvoiceItem: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var amount: Int
    public private(set) var description: String?
    public private(set) var isDiscountable: Bool
    public private(set) var isLiveMode: Bool
    public private(set) var periodStart: Date?
    public private(set) var periodEnd: Date?
    public private(set) var isProration: Bool
    public private(set) var quantity: Int?
    public private(set) var subscription: String?
    public private(set) var subscriptionItem: String?
    
    public private(set) var plan: Plan?
    
    public private(set) var metadata: Node?
    
    public private(set) var currency: StripeCurrency?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.amount = try node.get("amount")
        self.description = try node.get("description")
        self.isDiscountable = try node.get("discountable")
        self.isLiveMode = try node.get("livemode")
        self.isProration = try node.get("proration")
        self.quantity = try node.get("quantity")
        self.subscription = try node.get("subscription")
        self.subscriptionItem = try node.get("subscription_item")
        
        self.plan = try node.get("plan")
        
        self.metadata = try node.get("metadata")
        
        if let period = node["period"]?.object {
            self.periodStart = period["start"]?.date
            self.periodEnd = period["end"]?.date
        }
        
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "amount": self.amount,
            "description": self.description,
            "discountable": self.isDiscountable,
            "livemode": self.isLiveMode,
            "proration": self.isProration,
            "quantity": self.quantity,
            "subscription": self.subscription,
            "subscription_item": self.subscriptionItem,
            "plan": self.plan,
            "metadata": self.metadata,
            "period": [
                "start": self.periodStart,
                "end": self.periodEnd
            ],
            "currency": self.currency?.rawValue
        ]
        
        return try Node(node: object)
    }
    
}
