//
//  Plans.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/17.
//
//

import Foundation

/**
 Plan object
 https://stripe.com/docs/api/curl#plan_object
 */

public struct StripePlan: StripeModel {
    public var id: String
    public var object: String
    public var active: Bool?
    public var aggregateUsage: String?
    public var amount: Int?
    public var billingScheme: BillingScheme?
    public var created: Date?
    public var currency: StripeCurrency?
    public var interval: StripePlanInterval?
    public var intervalCount: Int?
    public var livemode: Bool?
    public var metadata: [String: String]
    public var nickname: String?
    public var product: String?
    public var tiers: [Tier]?
    public var tiersMode: TiersMode?
    public var transformUsage: UsageTransformation?
    public var trialPeriodDays: Int?
    public var usageType: UsageType?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case active
        case aggregateUsage = "aggregate_usage"
        case amount
        case billingScheme = "billing_scheme"
        case created
        case currency
        case interval
        case intervalCount = "interval_count"
        case livemode
        case metadata
        case nickname
        case product
        case tiers
        case tiersMode = "tiers_mode"
        case transformUsage = "transform_usage"
        case trialPeriodDays = "trial_period_days"
        case usageType = "usage_type"
    }
}
