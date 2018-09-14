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

public struct StripeSourcesList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var totalCount: Int?
    public var url: String?
    public var data: [StripePaymentSource]?
    
    public enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case data
    }
}

extension StripeSourcesList {
    
    public var bankAccounts: [StripeBankAccount]? {
        return data?.compactMap { $0.bankAccount }
    }
    
    public var cards: [StripeCard]? {
        return data?.compactMap { $0.card }
    }
    
    public var sources: [StripeSource]? {
        return data?.compactMap { $0.source }
    }
}
