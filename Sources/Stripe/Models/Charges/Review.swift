//
//  Review.swift
//  Stripe
//
//  Created by Andrew Edwards on 2/11/18.
//

import Foundation

/**
 Review object
 https://stripe.com/docs/api/curl#review_object
 */

public protocol Review {
    var id: String? { get }
    var object: String? { get }
    var charge: String? { get }
    var created: Date? { get }
    var livemode: Bool? { get }
    var open: Bool? { get }
    var reason: ReviewReason? { get }
}

public struct StripeReview: Review, StripeModel {
    public var id: String?
    public var object: String?
    public var charge: String?
    public var created: Date?
    public var livemode: Bool?
    public var open: Bool?
    public var reason: ReviewReason?
}
