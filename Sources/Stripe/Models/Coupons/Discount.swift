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

public protocol Discount {
    associatedtype C: Coupon
    
    var object: String? { get }
    var coupon: C? { get }
    var customer: String? { get }
    var end: Date? { get }
    var start: Date? { get }
    var subscription: String? { get }
}

public struct StripeDiscount: Discount, StripeModel {
    public var object: String?
    public var coupon: StripeCoupon?
    public var customer: String?
    public var end: Date?
    public var start: Date?
    public var subscription: String?
}
