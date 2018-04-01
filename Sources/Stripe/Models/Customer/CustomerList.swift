//
//  CustomerList.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//

/**
 Customers List
 https://stripe.com/docs/api/curl#list_customers
 */

public struct CustomersList: List, StripeModel {
    public var object: String?
    public var hasMore: Bool?
    public var totalCount: Int?
    public var url: String?
    public var data: [StripeCustomer]?
    
    public enum CodingKeys: CodingKey, String {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case data
    }
}
