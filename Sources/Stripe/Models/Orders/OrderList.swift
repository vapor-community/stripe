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

public struct OrdersList: List, StripeModelProtocol {
    public var object: String?
    public var hasMore: Bool?
    public var totalCount: Int?
    public var url: String?
    public var items: [StripeOrder]?
    
    enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case items = "data"
    }
}
