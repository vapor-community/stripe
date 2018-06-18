//
//  SKUList.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

/**
 SKU List
 https://stripe.com/docs/api/curl#list_skus
 */

public struct SKUList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var totalCount: Int
    public var url: String
    public var data: [StripeSKU]
    
    public enum CodingKeys: CodingKey, String {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case data
    }
}
