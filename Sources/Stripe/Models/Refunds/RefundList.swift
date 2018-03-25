//
//  RefundList.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

/**
 Refunds list
 https://stripe.com/docs/api/curl#charge_object-refunds
 */

public struct RefundsList: List, StripeModel {
    public var object: String?
    public var hasMore: Bool?
    public var totalCount: Int?
    public var url: String?
    public var data: [StripeRefund]?
}
