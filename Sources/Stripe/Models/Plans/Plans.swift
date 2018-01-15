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
    var intervalCount: String? { get }
    var isLive: Bool? { get }
    var metadata: [String: String]? { get }
    var name: String? { get }
    var statementDescriptor: String? { get }
    var trialPeriodDays: Int? { get }
}

public struct StripePlan: Plan, StripeModelProtocol {
    public var id: String?
    public var object: String?
    public var amount: Int?
    public var created: Date?
    public var currency: StripeCurrency?
    public var interval: StripePlanInterval?
    public var intervalCount: String?
    public var isLive: Bool?
    public var metadata: [String: String]?
    public var name: String?
    public var statementDescriptor: String?
    public var trialPeriodDays: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case created
        case currency
        case interval
        case intervalCount = "interval_count"
        case isLive = "livemode"
        case metadata
        case name
        case statementDescriptor = "statement_descriptor"
        case trialPeriodDays = "trial_period_days"
    }
}
