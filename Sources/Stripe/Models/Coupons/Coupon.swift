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

public protocol Coupon {
    var id: String? { get }
    var object: String? { get }
    var amountOff: Int? { get }
    var created: Date? { get }
    var currency: StripeCurrency? { get }
    var duration: StripeDuration? { get }
    var durationInMonths: Int? { get }
    var isLive: Bool? { get }
    var maxRedemptions: Int? { get }
    var metadata: [String: String]? { get }
    var percentOff: Int? { get }
    var redeemBy: Date? { get }
    var timesRedeemed: Int? { get }
    var isValid: Bool? { get }
}

public struct StripeCoupon: Coupon, StripeModel {
    public var id: String?
    public var object: String?
    public var amountOff: Int?
    public var created: Date?
    public var currency: StripeCurrency?
    public var duration: StripeDuration?
    public var durationInMonths: Int?
    public var isLive: Bool?
    public var maxRedemptions: Int?
    public var metadata: [String: String]?
    public var percentOff: Int?
    public var redeemBy: Date?
    public var timesRedeemed: Int?
    public var isValid: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case amountOff = "amount_off"
        case created
        case currency
        case duration
        case durationInMonths = "duration_in_months"
        case isLive = "livemode"
        case maxRedemptions = "max_redemptions"
        case metadata
        case percentOff = "percent_off"
        case redeemBy = "redeem_by"
        case timesRedeemed = "times_redeemed"
        case isValid = "valid"
    }
}
