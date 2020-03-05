//
//  Coupon.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/28/17.
//
//

import Foundation

/**
 Coupon Model
 https://stripe.com/docs/api/curl#coupon_object
 */

public struct StripeCoupon: StripeModel {
    public var id: String
    public var object: String
    public var amountOff: Int?
    public var created: Date?
    public var currency: StripeCurrency?
    public var duration: StripeDuration?
    public var durationInMonths: Int?
    public var livemode: Bool?
    public var maxRedemptions: Int?
    public var metadata: [String: String]
    public var percentOff: Int?
    public var redeemBy: Date?
    public var timesRedeemed: Int?
    public var valid: Bool?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case amountOff = "amount_off"
        case created
        case currency
        case duration
        case durationInMonths = "duration_in_months"
        case livemode
        case maxRedemptions = "max_redemptions"
        case metadata
        case percentOff = "percent_off"
        case redeemBy = "redeem_by"
        case timesRedeemed = "times_redeemed"
        case valid
    }
}
