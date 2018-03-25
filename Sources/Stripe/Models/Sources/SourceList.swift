//
//  SourceList.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//

/**
 Sources list
 https://stripe.com/docs/api#customer_object-sources
 */

public struct StripeSourcesList: List, StripeModel {
    public var object: String?
    public var hasMore: Bool?
    public var totalCount: Int?
    public var url: String?
    public var data: [StripeSource]?
}
