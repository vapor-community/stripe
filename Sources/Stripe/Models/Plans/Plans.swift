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

public protocol Plan {
    var id: String? { get }
    var object: String? { get }
    var amount: Int? { get }
    var created: Date? { get }
    var currency: StripeCurrency? { get }
    var interval: StripePlanInterval? { get }
    var intervalCount: Int? { get }
    var livemode: Bool? { get }
    var metadata: [String: String]? { get }
    var nickname: String? { get }
    var product: String? { get }
    var trialPeriodDays: Int? { get }
}

public struct StripePlan: Plan, StripeModel {
    public var id: String?
    public var object: String?
    public var amount: Int?
    public var created: Date?
    public var currency: StripeCurrency?
    public var interval: StripePlanInterval?
    public var intervalCount: Int?
    public var livemode: Bool?
    public var metadata: [String: String]?
    public var nickname: String?
    public var product: String?
    public var trialPeriodDays: Int?
    
    public enum CodingKeys: CodingKey, String {
        case id
        case object
        case amount
        case created
        case currency
        case interval
        case intervalCount = "interval_count"
        case livemode
        case metadata
        case nickname
        case product
        case trialPeriodDays = "trial_period_days"
    }
}
