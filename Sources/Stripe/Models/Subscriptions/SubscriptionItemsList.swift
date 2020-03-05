//
//  SubscriptionItemsList.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/8/17.
//
//

/**
 SubscriptionItem List
 https://stripe.com/docs/api/curl#list_subscription_items
 */

public struct SubscriptionItemsList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var totalCount: Int?
    public var url: String?
    public var data: [StripeSubscriptionItem]?
    
    public enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case data
    }
}
