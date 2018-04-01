//
//  PayoutSchedule.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

/**
 Payout Schedule object
 https://stripe.com/docs/api/curl#account_object-payout_schedule
 */

public protocol PayoutSchedule {
    var delayDays: Int? { get }
    var interval: StripePayoutInterval? { get }
    var monthlyAnchor: Int? { get }
    var weeklyAnchor: StripeWeeklyAnchor? { get }
}

public struct StripePayoutSchedule: PayoutSchedule, StripeModel {
    public var delayDays: Int?
    public var interval: StripePayoutInterval?
    public var monthlyAnchor: Int?
    public var weeklyAnchor: StripeWeeklyAnchor?
    
    public enum CodingKeys: CodingKey, String {
        case delayDays = "delay_days"
        case interval
        case monthlyAnchor = "monthly_anchor"
        case weeklyAnchor = "weekly_anchor"
    }
}
