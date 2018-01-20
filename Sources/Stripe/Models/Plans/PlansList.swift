//
//  PlansList.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/17.
//
//

/**
 Plans List
 https://stripe.com/docs/api/curl#list_plans
 */

public struct PlansList: List, StripeModel {
    public var object: String?
    public var hasMore: Bool?
    public var totalCount: Int?
    public var url: String?
    public var items: [StripePlan]?
    
    enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case items = "data"
    }
}
