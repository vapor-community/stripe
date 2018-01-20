//
//  ProductsList.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

/**
 Products List
 https://stripe.com/docs/api/curl#list_products
 */

public struct ProductsList: List, StripeModel {
    public var object: String?
    public var hasMore: Bool?
    public var totalCount: Int?
    public var url: String?
    public var items: [StripeProduct]?
    
    enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case items = "data"
    }
}
