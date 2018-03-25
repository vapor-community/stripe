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

public struct ConnectedAccountsList: List, StripeModel {
    public var object: String?
    public var hasMore: Bool?
    public var totalCount: Int?
    public var url: String?
    public var data: [StripeConnectAccount]?
}
