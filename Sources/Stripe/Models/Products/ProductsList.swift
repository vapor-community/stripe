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
    public var data: [StripeProduct]?
}
