//
//  Discount.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/7/17.
//
//

import Foundation
import Vapor

/**
 Discount Model
 https://stripe.com/docs/api/curl#discount_object
 */

public struct StripeDiscount: StripeModel {
    public var object: String
    public var coupon: StripeCoupon?
    public var customer: String?
    public var end: Date?
    public var start: Date
    public var subscription: String?
}
