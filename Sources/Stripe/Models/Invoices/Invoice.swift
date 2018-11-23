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

public struct StripeInvoice: StripeModel {
    public var id: String?
    public var object: String
    public var amountDue: Int?
    public var amountPaid: Int?
    public var amountRemanining: Int?
    public var applicationFee: Int?
    public var attemptCount: Int?
    public var attempted: Bool?
    public var autoAdvance: Bool?
    public var billing: String?
    public var billingReason: StripeBillingReason?
    public var charge: String?
    public var closed: Bool?
    public var currency: StripeCurrency?
    public var customer: String?
    public var date: Date?
    public var defaultSource: String?
    public var description: String?
    public var discount: StripeDiscount?
    public var dueDate: Date?
    public var endingBalance: Int?
    public var finalizedAt: Date?
    public var forgiven: Bool?
    public var hostedInvoiceUrl: String?
    public var invoicePdf: String?
    public var lines: InvoiceLineGroup?
    public var livemode: Bool?
    public var metadata: [String: String]
    public var nextPaymentAttempt: Date?
    public var number: String?
    public var paid: Bool?
    public var periodEnd: Date?
    public var periodStart: Date?
    public var receiptNumber: String?
    public var startingBalance: Int?
    public var statementDescriptor: String?
    public var status: StripeInvoiceStatus?
    public var subscription: String?
    public var subscriptionProrationDate: Int?
    public var subtotal: Int?
    public var total: Int?
    public var tax: Int?
    public var taxPercent: Decimal?
    public var webhooksDeliveredAt: Date?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case amountDue = "amount_due"
        case amountPaid = "amount_paid"
        case amountRemanining = "amount_remaining"
        case applicationFee = "application_fee"
        case attemptCount = "attempt_count"
        case attempted
        case autoAdvance = "auto_advance"
        case billing
        case billingReason = "billing_reason"
        case charge
        case closed
        case currency
        case customer
        case date
        case defaultSource = "default_source"
        case description
        case discount
        case dueDate = "due_date"
        case endingBalance = "ending_balance"
        case finalizedAt = "finalized_at"
        case forgiven
        case hostedInvoiceUrl = "hosted_invoice_url"
        case invoicePdf = "invoice_pdf"
        case lines
        case livemode
        case metadata
        case nextPaymentAttempt = "next_payment_attempt"
        case number
        case paid
        case periodEnd = "period_end"
        case periodStart = "period_start"
        case receiptNumber = "receipt_number"
        case startingBalance = "starting_balance"
        case statementDescriptor = "statement_descriptor"
        case status
        case subscription
        case subscriptionProrationDate = "subscription_proration_date"
        case subtotal
        case total
        case tax
        case taxPercent = "tax_percent"
        case webhooksDeliveredAt = "webhooks_delivered_at"
    }
}
