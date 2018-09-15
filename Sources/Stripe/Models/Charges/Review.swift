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

public struct StripeReview: StripeModel {
    public var id: String
    public var object: String
    public var charge: String
    public var created: Date?
    public var livemode: Bool?
    public var open: Bool?
    public var reason: ReviewReason?
}
