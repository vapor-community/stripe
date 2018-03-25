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
}
