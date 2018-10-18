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

public struct StripeInvoiceItem: StripeModel {
    public var id: String?
    public var object: String
    public var amount: Int?
    public var currency: StripeCurrency?
    public var customer: String?
    public var date: Date?
    public var description: String?
    public var discountable: Bool?
    public var invoice: String?
    public var livemode: Bool?
    public var metadata: [String: String]
    public var period: Period?
    public var plan: StripePlan?
    public var proration: Bool?
    public var quantity: Int?
    public var subscription: String?
    public var subscriptionItem: String?
    public var unitAmount: Int?
    
    public enum CodingKeys: String, CodingKey {
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
        case unitAmount = "unit_amount"
    }
}
