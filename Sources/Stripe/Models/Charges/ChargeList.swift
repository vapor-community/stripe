//
//  ChargeList.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/17/17.
//
//

/**
 Charges list
 https://stripe.com/docs/api/curl#list_charges
 */

public struct ChargesList: List, StripeModel {
    public var object: String?
    public var hasMore: Bool?
    public var totalCount: Int?
    public var url: String?
    public var data: [StripeCharge]?
}
