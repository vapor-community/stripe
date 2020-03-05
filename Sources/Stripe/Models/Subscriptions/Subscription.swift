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

public struct StripeSubscription: StripeModel {
    public var id: String
    public var object: String
    public var applicationFeePercent: Decimal?
    public var billing: String?
    public var billingCycleAnchor: Date?
    public var cancelAtPeriodEnd: Bool?
    public var canceledAt: Date?
    public var created: Date?
    public var currentPeriodEnd: Date?
    public var currentPeriodStart: Date?
    public var customer: String?
    public var daysUntilDue: Int?
    public var discount: StripeDiscount?
    public var endedAt: Date?
    public var items: SubscriptionItemsList?
    public var livemode: Bool?
    public var metadata: [String: String]
    public var plan: StripePlan?
    public var quantity: Int?
    public var start: Date?
    public var status: StripeSubscriptionStatus?
    public var taxPercent: Decimal?
    public var trialEnd: Date?
    public var trialStart: Date?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case applicationFeePercent = "application_fee_percent"
        case billing
        case billingCycleAnchor = "billing_cycle_anchor"
        case cancelAtPeriodEnd = "cancel_at_period_end"
        case canceledAt = "canceled_at"
        case created
        case currentPeriodEnd = "current_period_end"
        case currentPeriodStart = "current_period_start"
        case customer
        case daysUntilDue = "days_until_due"
        case discount
        case endedAt = "ended_at"
        case items
        case livemode
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
