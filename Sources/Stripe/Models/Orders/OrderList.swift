//
//  OrderList.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

/**
 Orders List
 https://stripe.com/docs/api/curl#list_orders
 */

public struct OrdersList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var totalCount: Int?
    public var url: String?
    public var data: [StripeOrder]?
    
    public enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case data
    }
}
