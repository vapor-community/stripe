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

public struct SKUList: List, StripeModel {
    public var object: String?
    public var hasMore: Bool?
    public var totalCount: Int?
    public var url: String?
    public var data: [StripeSKU]?
}
