//
//  OrderReturnList.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/25/17.
//
//

/**
 Order return List
 https://stripe.com/docs/api#list_order_returns
 */

public struct OrderReturnList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var totalCount: Int
    public var url: String
    public var data: [StripeOrderReturn]
    
    public enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case data
    }
}
