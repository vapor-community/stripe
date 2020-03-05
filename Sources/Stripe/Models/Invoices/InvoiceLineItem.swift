//
//  InvoiceLineItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/5/17.
//
//

import Foundation

/**
 InvoiceItem object
 https://stripe.com/docs/api#invoice_line_item_object
 */

public struct StripeInvoiceLineItem: StripeModel {
    public var id: String?
    public var object: String
    public var amount: Int?
    public var currency: StripeCurrency?
    public var description: String?
    public var discountable: Bool?
    public var livemode: Bool?
    public var metadata: [String: String]
    public var period: Period?
    public var plan: StripePlan?
    public var proration: Bool?
    public var quantity: Int?
    public var subscription: String?
    public var subscriptionItem: String?
    public var type: String?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case currency
        case description
        case discountable
        case livemode
        case metadata
        case period
        case plan
        case proration
        case quantity
        case subscription
        case subscriptionItem = "subscription_item"
        case type
    }
}
