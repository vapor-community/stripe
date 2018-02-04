//
//  Invoice.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/4/17.
//
//

import Foundation

/**
 Invoice object
 https://stripe.com/docs/api#invoice_object
 */

public protocol Invoice {
    associatedtype D: Discount
    associatedtype L: List
    
    var id: String? { get }
    var object: String? { get }
    var amountDue: Int? { get }
    var applicationFee: Int? { get }
    var attemptCount: Int?  { get }
    var attempted: Bool? { get }
    var billing: String? { get }
    var charge: String?  { get }
    var closed: Bool?  { get }
    var currency: StripeCurrency? { get }
    var customer: String? { get }
    var date: Date? { get }
    var description: String? { get }
    var discount: D? { get }
    var dueDate: Date? { get }
    var endingBalance: Int? { get }
    var forgiven: Bool?  { get }
    var lines: [L]? { get }
    var livemode: Bool?  { get }
    var metadata: [String: String]? { get }
    var nextPaymentAttempt: Date? { get }
    var number: String? { get }
    var paid: Bool?  { get }
    var periodEnd: Date? { get }
    var periodStart: Date? { get }
    var receiptNumber: String? { get }
    var startingBalance: Int? { get }
    var statementDescriptor: String? { get }
    var subscription: String? { get }
    var subscriptionProrationDate: Int? { get }
    var subtotal: Int? { get }
    var total: Int? { get }
    var tax: Int? { get }
    var taxPercent: Decimal? { get }
    var webhooksDeliveredAt: Date? { get }
}

public struct StripeInvoice: Invoice, StripeModel {
    public var id: String?
    public var object: String?
    public var amountDue: Int?
    public var applicationFee: Int?
    public var attemptCount: Int?
    public var attempted: Bool?
    public var billing: String?
    public var charge: String?
    public var closed: Bool?
    public var currency: StripeCurrency?
    public var customer: String?
    public var date: Date?
    public var description: String?
    public var discount: StripeDiscount?
    public var dueDate: Date?
    public var endingBalance: Int?
    public var forgiven: Bool?
    public var lines: [InvoiceLineGroup]?
    public var livemode: Bool?
    public var metadata: [String: String]?
    public var nextPaymentAttempt: Date?
    public var number: String?
    public var paid: Bool?
    public var periodEnd: Date?
    public var periodStart: Date?
    public var receiptNumber: String?
    public var startingBalance: Int?
    public var statementDescriptor: String?
    public var subscription: String?
    public var subscriptionProrationDate: Int?
    public var subtotal: Int?
    public var total: Int?
    public var tax: Int?
    public var taxPercent: Decimal?
    public var webhooksDeliveredAt: Date?
}
