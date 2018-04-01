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
    var defaultSource: String? { get }
    var delinquent: Bool? { get }
    var description: String? { get }
    var discount: D? { get }
    var email: String? { get }
    var livemode: Bool? { get }
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
    public var defaultSource: String?
    public var delinquent: Bool?
    public var description: String?
    public var discount: StripeDiscount?
    public var email: String?
    public var livemode: Bool?
    public var metadata: [String : String]?
    public var shipping: ShippingLabel?
    public var sources: StripeSourcesList?
    public var subscriptions: SubscriptionList?
    
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
