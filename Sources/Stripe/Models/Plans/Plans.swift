//
//  Plans.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/17.
//
//

import Foundation
import Vapor

/**
 Plan Model
 https://stripe.com/docs/api/curl#plan_object
 */
open class Plan: StripeModelProtocol {
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var amount: Int?
    public private(set) var created: Date?
    public private(set) var currency: StripeCurrency?
    public private(set) var interval: StripeInterval?
    public private(set) var intervalCount: Int?
    public private(set) var isLive: Bool?
    
    /**
     Only these values are mutable/updatable.
     https://stripe.com/docs/api/curl#update_plan
     */
    
    public private(set) var metadata: Node?
    public private(set) var name: String?
    public private(set) var statementDescriptor: String?
    public private(set) var trialPeriodDays: Int?
    
    public init() {}
    
    public required init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.amount = try node.get("amount")
        self.created = try node.get("created")
        
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        
        if let interval = node["interval"]?.string {
            self.interval = StripeInterval(rawValue: interval)
        }
        
        self.intervalCount = try node.get("interval_count")
        self.isLive = try node.get("livemode")
        self.metadata = try node.get("metadata")
        self.name = try node.get("name")
        self.statementDescriptor = try node.get("statement_descriptor")
        self.trialPeriodDays = try node.get("trial_period_days")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "amount": self.amount,
            "created": self.created,
            "currency": self.currency,
            "interval": self.interval,
            "interval_count": self.intervalCount,
            "livemode": self.isLive,
            "metadata": self.metadata,
            "name": self.name,
            "statement_descriptor": self.statementDescriptor,
            "trial_period_days": self.trialPeriodDays
        ]
        
        return try Node(node: object)
    }
}
