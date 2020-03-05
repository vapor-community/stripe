//
//  ReviewReason.swift
//  Stripe
//
//  Created by Andrew Edwards on 2/11/18.
//

/**
 ReviewReason
 https://stripe.com/docs/api/curl#review_object-reason
 */

public enum ReviewReason: String, Codable {
    case rule
    case manual
    case approved
    case refunded
    case refundedAsFraud = "refunded_as_fraud"
    case disputed
}
