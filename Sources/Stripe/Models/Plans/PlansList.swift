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

public struct PlansList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var totalCount: Int
    public var url: String
    public var data: [StripePlan]
    
    public enum CodingKeys: CodingKey, String {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case data
    }
}
