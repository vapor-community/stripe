//
//  SubscriptionItem.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/6/17.
//
//

import Foundation

/**
 SubscriptionItem object
 https://stripe.com/docs/api/curl#subscription_items
 */

public struct StripeSubscriptionItem: StripeModel {
    public var id: String
    public var object: String
    public var created: Date?
    public var metadata: [String: String]
    public var plan: StripePlan?
    public var quantity: Int?
    public var subscription: String?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case created
        case metadata
        case plan
        case quantity
        case subscription
    }
}
