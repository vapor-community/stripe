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
    var isDiscountable: Bool? { get }
    var isLive: Bool? { get }
    var metadata: [String: String]? { get }
    var period: Period? { get }
    var plan: P? { get }
    var isProration: Bool? { get }
    var quantity: Int? { get }
    var subscription: String? { get }
    var subscriptionItem: String? { get }
    var type: String? { get }
}

public struct StripeInvoiceLineItem: InvoiceLineItem, StripeModelProtocol {
    public var id: String?
    public var object: String?
    public var amount: Int?
    public var currency: StripeCurrency?
    public var description: String?
    public var isDiscountable: Bool?
    public var isLive: Bool?
    public var metadata: [String : String]?
    public var period: Period?
    public var plan: StripePlan?
    public var isProration: Bool?
    public var quantity: Int?
    public var subscription: String?
    public var subscriptionItem: String?
    public var type: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case currency
        case description
        case isDiscountable = "discountable"
        case isLive = "livemode"
        case metadata
        case period
        case plan
        case isProration = "proration"
        case quantity
        case subscription
        case subscriptionItem = "subscription_item"
        case type
    }
}
