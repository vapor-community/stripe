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

public protocol SubscriptionItem {
    associatedtype P: Plan
    
    var id: String? { get }
    var object: String? { get }
    var created: Date? { get }
    var plan: P? { get }
    var quantity: Int? { get }
}

public struct StripeSubscriptionItem: SubscriptionItem, StripeModel {
    public var id: String?
    public var object: String?
    public var created: Date?
    public var plan: StripePlan?
    public var quantity: Int?
}
