//
//  InvoiceItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/5/17.
//
//

import Foundation
import Vapor

/**
 Invoice Items
 https://stripe.com/docs/api#invoiceitems
 */
public final class InvoiceItem: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var amount: Int
    public private(set) var customer: String?
    public private(set) var date: Date?
    public private(set) var description: String?
    public private(set) var isDiscountable: Bool
    public private(set) var isLiveMode: Bool
    public private(set) var isProration: Bool
    public private(set) var periodStart: Date?
    public private(set) var periodEnd: Date?
    public private(set) var quantity: Int?
    public private(set) var subscription: String?
    
    public private(set) var metadata: Node?
    
    public private(set) var plan: Plan?
    public private(set) var currency: StripeCurrency?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.amount = try node.get("amount")
        self.customer = try node.get("customer")
        self.date = try node.get("date")
        self.description = try node.get("description")
        self.isDiscountable = try node.get("discountable")
        self.isLiveMode = try node.get("livemode")
        self.isProration = try node.get("proration")
        self.quantity = try node.get("qantity")
        self.subscription = try node.get("subscription")
        
        if let period = node["period"]?.object {
            self.periodStart = period["start"]?.date
            self.periodEnd = period["end"]?.date
        }
        
        self.metadata = try node.get("metadata")
        
        self.plan = try? node.get("plan")
        
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "amount": self.amount,
            "customer": self.customer,
            "date": self.date,
            "description": self.description,
            "discountable": self.isDiscountable,
            "livemode": self.isLiveMode,
            "proration": self.isProration,
            "quantity": self.quantity,
            "subscription": self.subscription,
            
            "period": [
                "start": self.periodStart,
                "end": self.periodEnd
            ],
            
            "metadata": self.metadata,
            
            "plan": self.plan,
            "currency": self.currency?.rawValue
        ]
        
        return try Node(node: object)
    }
}

public final class InvoiceItemList: StripeModelProtocol {
    
    public private(set) var object: String?
    public private(set) var hasMore: Bool?
    public private(set) var items: [InvoiceItem]?
    
    public init(node: Node) throws {
        self.object = try node.get("object")
        self.hasMore = try node.get("has_more")
        self.items = try node.get("data")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "object": self.object,
            "has_more": self.hasMore,
            "data": self.items
        ]
        return try Node(node: object)
    }
    
}
