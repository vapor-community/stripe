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
    var chargeId: String?  { get }
    var isClosed: Bool?  { get }
    var currency: StripeCurrency? { get }
    var customer: String? { get }
    var date: Date? { get }
    var description: String? { get }
    var discount: D? { get }
    var dueDate: Date? { get }
    var endingBalance: Int? { get }
    var isForgiven: Bool?  { get }
    var lines: [L]? { get }
    var isLive: Bool?  { get }
    var metadata: [String: String]? { get }
    var nextPaymentAttempt: Date? { get }
    var number: String? { get }
    var isPaid: Bool?  { get }
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

public struct StripeInvoice: Invoice, StripeModelProtocol {
    public var id: String?
    public var object: String?
    public var amountDue: Int?
    public var applicationFee: Int?
    public var attemptCount: Int?
    public var attempted: Bool?
    public var billing: String?
    public var chargeId: String?
    public var isClosed: Bool?
    public var currency: StripeCurrency?
    public var customer: String?
    public var date: Date?
    public var description: String?
    public var discount: StripeDiscount?
    public var dueDate: Date?
    public var endingBalance: Int?
    public var isForgiven: Bool?
    public var lines: [InvoiceLineGroup]?
    public var isLive: Bool?
    public var metadata: [String: String]?
    public var nextPaymentAttempt: Date?
    public var number: String?
    public var isPaid: Bool?
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
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case amountDue = "amount_due"
        case applicationFee = "application_fee"
        case attemptCount = "attempt_count"
        case attempted
        case billing
        case chargeId = "charge"
        case isClosed = "closed"
        case currency
        case customer
        case date
        case description
        case discount
        case dueDate = "due_date"
        case endingBalance = "ending_balance"
        case isForgiven = "forgiven"
        case lines
        case isLive = "livemode"
        case metadata
        case nextPaymentAttempt = "next_payment_attempt"
        case number
        case isPaid = "paid"
        case periodEnd = "period_end"
        case periodStart = "period_start"
        case receiptNumber = "receipt_number"
        case startingBalance = "starting_balance"
        case statementDescriptor = "statement_descriptor"
        case subscription
        case subscriptionProrationDate = "subscription_proration_date"
        case subtotal
        case total
        case tax
        case taxPercent = "tax_percent"
        case webhooksDeliveredAt = "webhooks_delivered_at"
    }
}
