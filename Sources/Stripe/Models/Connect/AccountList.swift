//
//  AccountList.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/9/17.
//
//

/**
 Connected Account list
 https://stripe.com/docs/api/curl#list_accounts
 */

public struct ConnectedAccountsList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var totalCount: Int
    public var url: String
    public var data: [StripeConnectAccount]
    
    public enum CodingKeys: CodingKey, String {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case data
    }
}
