//
//  PaymentIntentsList.swift
//  Stripe
//
//  Created by Ben Syverson on 2019-02-28.
//
//
/**
 Customers List
 https://stripe.com/docs/api/payment_intents/list?lang=curl
 */

public struct StripePaymentIntentsList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var totalCount: Int?
    public var url: String?
    public var data: [StripePaymentIntents]?
    
    public enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case data
    }
}
