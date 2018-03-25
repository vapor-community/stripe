//
//  BalanceHistoryList.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

/**
 BalanceHistory list
 https://stripe.com/docs/api#balance_history
 */

public struct BalanceHistoryList: List, StripeModel {
    public var object: String?
    public var hasMore: Bool?
    public var totalCount: Int?
    public var url: String?
    public var data: [StripeBalance]?
}
