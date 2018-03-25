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

public protocol InvoiceLineItem {
    associatedtype P: Plan
    
    var id: String? { get }
    var object: String? { get }
    var amount: Int? { get }
    var currency: StripeCurrency? { get }
    var description: String? { get }
    var discountable: Bool? { get }
    var livemode: Bool? { get }
    var metadata: [String: String]? { get }
    var period: Period? { get }
    var plan: P? { get }
    var proration: Bool? { get }
    var quantity: Int? { get }
    var subscription: String? { get }
    var subscriptionItem: String? { get }
    var type: String? { get }
}

public struct StripeInvoiceLineItem: InvoiceLineItem, StripeModel {
    public var id: String?
    public var object: String?
    public var amount: Int?
    public var currency: StripeCurrency?
    public var description: String?
    public var discountable: Bool?
    public var livemode: Bool?
    public var metadata: [String : String]?
    public var period: Period?
    public var plan: StripePlan?
    public var proration: Bool?
    public var quantity: Int?
    public var subscription: String?
    public var subscriptionItem: String?
    public var type: String?
}
