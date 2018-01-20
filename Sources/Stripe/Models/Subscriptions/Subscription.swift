//
//  Subscription.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/6/17.
//
//

import Foundation

/**
 Subscription object
 https://stripe.com/docs/api/curl#subscription_object
 */

public protocol Subscription {
    associatedtype D: Discount
    associatedtype L: List
    associatedtype P: Plan
    
    var id: String? { get }
    var object: String? { get }
    var applicationFeePercent: Decimal? { get }
    var billing: String? { get }
    var cancelAtPeriodEnd: Bool? { get }
    var canceledAt: Date? { get }
    var created: Date? { get }
    var currentPeriodEnd: Date? { get }
    var currentPeriodStart: Date? { get }
    var customerId: String? { get }
    var daysUntilDue: Int? { get }
    var discount: D? { get }
    var endedAt: Date? { get }
    var items: L? { get }
    var isLive: Bool? { get }
    var metadata: [String: String]? { get }
    var plan: P? { get }
    var quantity: Int? { get }
    var start: Date? { get }
    var status: StripeSubscriptionStatus? { get }
    var taxPercent: Decimal? { get }
    var trialEnd: Date? { get }
    var trialStart: Date? { get }
}

public struct StripeSubscription: Subscription, StripeModel {
    public var id: String?
    public var object: String?
    public var applicationFeePercent: Decimal?
    public var billing: String?
    public var cancelAtPeriodEnd: Bool?
    public var canceledAt: Date?
    public var created: Date?
    public var currentPeriodEnd: Date?
    public var currentPeriodStart: Date?
    public var customerId: String?
    public var daysUntilDue: Int?
    public var discount: StripeDiscount?
    public var endedAt: Date?
    public var items: SubscriptionItemList?
    public var isLive: Bool?
    public var metadata: [String : String]?
    public var plan: StripePlan?
    public var quantity: Int?
    public var start: Date?
    public var status: StripeSubscriptionStatus?
    public var taxPercent: Decimal?
    public var trialEnd: Date?
    public var trialStart: Date?
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case applicationFeePercent = "application_fee_percent"
        case billing
        case cancelAtPeriodEnd = "cancel_at_period_end"
        case canceledAt = "canceled_at"
        case created
        case currentPeriodEnd = "current_period_end"
        case currentPeriodStart = "current_period_start"
        case customerId = "customer"
        case daysUntilDue = "days_until_due"
        case discount
        case endedAt = "ended_at"
        case items
        case isLive = "livemode"
        case metadata
        case plan
        case quantity
        case start
        case status
        case taxPercent = "tax_percent"
        case trialEnd = "trial_end"
        case trialStart = "trial_start"
    }
}
