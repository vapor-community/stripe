//
//  InvoiceItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/5/17.
//
//

import Foundation

/**
 Invoice Items
 https://stripe.com/docs/api#invoiceitems
 */

public protocol InvoiceItem {
    associatedtype P: Plan
    
    var id: String? { get }
    var object: String? { get }
    var amount: Int? { get }
    var currency: StripeCurrency? { get }
    var customer: String? { get }
    var date: Date? { get }
    var description: String? { get }
    var discountable: Bool? { get }
    var invoice: String? { get }
    var livemode: Bool? { get }
    var metadata: [String: String]? { get }
    var period: Period? { get }
    var plan: P? { get }
    var proration: Bool? { get }
    var quantity: Int? { get }
    var subscription: String? { get }
    var subscriptionItem: String? { get }
}

public struct StripeInvoiceItem: InvoiceItem, StripeModel {
    public var id: String?
    public var object: String?
    public var amount: Int?
    public var currency: StripeCurrency?
    public var customer: String?
    public var date: Date?
    public var description: String?
    public var discountable: Bool?
    public var invoice: String?
    public var livemode: Bool?
    public var metadata: [String : String]?
    public var period: Period?
    public var plan: StripePlan?
    public var proration: Bool?
    public var quantity: Int?
    public var subscription: String?
    public var subscriptionItem: String?
    
    public enum CodingKeys: CodingKey, String {
        case id
        case object
        case amount
        case currency
        case customer
        case date
        case description
        case discountable
        case invoice
        case livemode
        case metadata
        case period
        case plan
        case proration
        case quantity
        case subscription
        case subscriptionItem = "subscription_item"
    }
}
