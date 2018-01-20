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

public protocol Customer {
    associatedtype S: Shipping
    associatedtype SRCL: List
    associatedtype SL: List
    associatedtype D: Discount
    
    var id: String? { get }
    var object: String? { get }
    var accountBalance: Int? { get }
    var bussinessVATId: String? { get }
    var created: Date? { get }
    var currency: StripeCurrency? { get }
    var defaultSourceId: String? { get }
    var isDelinquent: Bool? { get }
    var description: String? { get }
    var discount: D? { get }
    var email: String? { get }
    var isLive: Bool? { get }
    var metadata: [String: String]? { get }
    var shipping: S? { get }
    var sources: SRCL? { get }
    var subscriptions: SL? { get }
}

public struct StripeCustomer: Customer, StripeModel {
    public var id: String?
    public var object: String?
    public var accountBalance: Int?
    public var bussinessVATId: String?
    public var created: Date?
    public var currency: StripeCurrency?
    public var defaultSourceId: String?
    public var isDelinquent: Bool?
    public var description: String?
    public var discount: StripeDiscount?
    public var email: String?
    public var isLive: Bool?
    public var metadata: [String : String]?
    public var shipping: ShippingLabel?
    public var sources: StripeSourcesList?
    public var subscriptions: SubscriptionList?
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case accountBalance = "account_balance"
        case bussinessVATId = "business_vat_id"
        case created
        case currency
        case defaultSourceId = "default_source"
        case isDelinquent = "delinquent"
        case description
        case discount
        case email
        case isLive = "livemode"
        case metadata
        case shipping
        case sources
        case subscriptions
    }
}
