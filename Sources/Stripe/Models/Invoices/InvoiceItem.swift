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
    var customerId: String? { get }
    var date: Date? { get }
    var description: String? { get }
    var isDiscountable: Bool? { get }
    var invoiceId: String? { get }
    var isLive: Bool? { get }
    var metadata: [String: String]? { get }
    var period: Period? { get }
    var plan: P? { get }
    var isProration: Bool? { get }
    var quantity: Int? { get }
    var subscription: String? { get }
    var subscriptionItem: String? { get }
}

public struct StripeInvoiceItem: InvoiceItem, StripeModel {
    public var id: String?
    public var object: String?
    public var amount: Int?
    public var currency: StripeCurrency?
    public var customerId: String?
    public var date: Date?
    public var description: String?
    public var isDiscountable: Bool?
    public var invoiceId: String?
    public var isLive: Bool?
    public var metadata: [String : String]?
    public var period: Period?
    public var plan: StripePlan?
    public var isProration: Bool?
    public var quantity: Int?
    public var subscription: String?
    public var subscriptionItem: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case currency
        case customerId = "customer"
        case date
        case description
        case isDiscountable = "discountable"
        case invoiceId = "invoice"
        case isLive = "livemode"
        case metadata
        case period
        case plan
        case isProration = "proration"
        case quantity
        case subscription
        case subscriptionItem = "subscription_item"
    }
}
