//
//  CouponList.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/28/17.
//
//

/**
 Coupons List
 https://stripe.com/docs/api#list_coupons
 */

public struct CouponsList: List, StripeModelProtocol {
    public var object: String?
    public var hasMore: Bool?
    public var totalCount: Int?
    public var url: String?
    public var items: [StripeCoupon]?
    
    enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case items = "data"
    }
}
