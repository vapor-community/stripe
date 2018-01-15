//
//  SubscriptionList.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//

/**
 Subscriptions List
 https://stripe.com/docs/api/curl#list_subscriptions
 */

public struct SubscriptionList: List, StripeModelProtocol {
    public var object: String?
    public var hasMore: Bool?
    public var totalCount: Int?
    public var url: String?
    public var items: [StripeSubscription]?
    
    enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case items = "data"
    }
}
