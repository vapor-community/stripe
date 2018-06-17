//
//  Customer.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/19/17.
//
//

import Foundation

/**
 Customer Model
 https://stripe.com/docs/api/curl#customer_object
 */

public struct StripeCustomer: StripeModel {
    public var id: String
    public var object: String
    public var accountBalance: Int
    public var bussinessVATId: String?
    public var created: Date
    public var currency: StripeCurrency?
    public var defaultSource: String?
    public var delinquent: Bool
    public var description: String?
    public var discount: StripeDiscount?
    public var email: String?
    public var livemode: Bool
    public var metadata: [String: String]
    public var shipping: ShippingLabel?
    public var sources: StripeSourcesList
    public var subscriptions: StripeSubscriptionsList
    
    public enum CodingKeys: CodingKey, String {
        case id
        case object
        case accountBalance = "account_balance"
        case bussinessVATId = "bussiness_vat_id"
        case created
        case currency
        case defaultSource = "default_source"
        case delinquent
        case description
        case discount
        case email
        case livemode
        case metadata
        case shipping
        case sources
        case subscriptions
    }
}
