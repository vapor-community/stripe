//
//  Subscription.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/6/17.
//
//

import Foundation
import Vapor
import Helpers

/**
 Subscription Model
 https://stripe.com/docs/api/curl#subscription_object
 */
public final class Subscription: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var cancelAtPeriodEnd: Bool?
    public private(set) var canceledAt: Date?
    public private(set) var created: Date?
    public private(set) var currentPeriodEnd: Date?
    public private(set) var currentPeriodStart: Date?
    public private(set) var customer: String?
    public private(set) var discount: Discount?
    public private(set) var endedAt: Date?
    public private(set) var items: SubscriptionItemList?
    public private(set) var isLive: Bool?
    public private(set) var plan: Plan?
    public private(set) var start: Date?
    public private(set) var status: StripeSubscriptionStatus?
    public private(set) var trialStart: Date?
    
    /**
     Only these values ore mutable/updatable
     https://stripe.com/docs/api/curl#update_subscription
     */
    public private(set) var applicationFeePercent: Double?
    public private(set) var metadata: Node?
    public private(set) var quantity: Int?
    public private(set) var taxPercent: Double?
    public private(set) var trialEnd: Date?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.applicationFeePercent = try node.get("application_fee_percent")
        self.cancelAtPeriodEnd = try node.get("cancel_at_period_end")
        self.canceledAt = try node.get("canceled_at")
        self.created = try node.get("created")
        self.currentPeriodEnd = try node.get("current_period_end")
        self.currentPeriodStart = try node.get("current_period_start")
        self.customer = try node.get("customer")
        self.discount = try node.get("discount")
        self.endedAt = try node.get("ended_at")
        self.items = try node.get("items")
        self.isLive = try node.get("livemode")
        self.metadata = try node.get("metadata")
        self.plan = try node.get("plan")
        self.quantity = try node.get("quantity")
        self.start = try node.get("start")
        if let status = node["status"]?.string {
            self.status = StripeSubscriptionStatus(rawValue: status)
        }
        self.taxPercent = try node.get("tax_percent")
        self.trialEnd = try node.get("trial_end")
        self.trialStart = try node.get("trial_start")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "application_fee_percent": self.applicationFeePercent,
            "cancel_at_period_end": self.cancelAtPeriodEnd,
            "canceled_at": self.canceledAt,
            "created": self.created,
            "current_period_end": self.currentPeriodEnd,
            "current_period_start": self.currentPeriodStart,
            "customer": self.customer,
            "discount": self.discount,
            "ended_at": self.endedAt,
            "items": self.items,
            "livemode": self.isLive,
            "metadata": self.metadata,
            "plan": self.plan,
            "quantity": self.quantity,
            "start": self.start,
            "status": self.status?.rawValue,
            "tax_percent": self.taxPercent,
            "trial_end": self.trialEnd,
            "trial_start": self.trialStart
        ]
        return try Node(node: object)
    }
}
