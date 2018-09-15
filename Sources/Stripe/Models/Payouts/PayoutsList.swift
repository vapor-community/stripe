//
//  PayoutsList.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/21/18.
//

/**
 Payouts List
 https://stripe.com/docs/api/curl#list_payouts
 */

public struct StripePayoutsList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var totalCount: Int?
    public var url: String?
    public var data: [StripePayout]?
    
    public enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case data
    }
}
