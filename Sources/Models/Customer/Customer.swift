//
//  Customer.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/19/17.
//
//

import Foundation
import Vapor
import Helpers

/**
 Customer Model
 https://stripe.com/docs/api/curl#customer_object
 */
public final class Customer: StripeModelProtocol {
    
    public private(set) var id: String
    public private(set) var object: String?
    public var accountBalance: Int?
    public private(set) var created: Date?
    public var email: String?
    public var bussinessVATId: String?
    public var defaultSourceId: String?
    public var description: String?
    public private(set) var delinquent: Bool?
    public private(set) var isLive: Bool?
    
    public var metadata: Node?
    
    public var currency: StripeCurrency?
    public private(set) var shipping: ShippingLabel?
    public private(set) var sources: SourceList?
    public private(set) var subscriptions: SubscriptionList?
    
    public init() {
        self.id = ""
    }
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.accountBalance = try node.get("account_balance")
        self.created = try node.get("created")
        self.email = try node.get("email")
        self.bussinessVATId = try node.get("business_vat_id")
        self.defaultSourceId = try node.get("default_source")
        self.description = try node.get("description")
        self.delinquent = try node.get("delinquent")
        self.isLive = try node.get("livemode")
        
        self.metadata = try node.get("metadata")
        
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        
        if let _ = node["shipping"]?.object {
            self.shipping = try node.get("shipping")
        }
        
        self.sources = try node.get("sources")
        self.subscriptions = try node.get("subscriptions")
    }

    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "id": self.id,
            "object": self.object,
            "account_balance": self.accountBalance,
            "created": self.created,
            "email": self.email,
            "business_vat_id": self.bussinessVATId,
            "description": self.description,
            "delinquent": self.delinquent,
            "livemode": self.isLive,
            
            "metadata": self.metadata,
            
            "currency": self.currency?.rawValue,
            "shipping": self.shipping,
            "sources": self.sources,
            "subscriptions": self.subscriptions
        ]
        return try Node(node: object)
    }
    
}
