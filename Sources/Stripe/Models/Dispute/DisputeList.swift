//
//  DisputeList.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/12/17.
//
//

/**
 Disputes List
 https://stripe.com/docs/api#list_disputes
 */

public struct DisputesList: List, StripeModel {
    public var object: String?
    public var hasMore: Bool?
    public var totalCount: Int?
    public var url: String?
    public var data: [StripeDispute]?
}
