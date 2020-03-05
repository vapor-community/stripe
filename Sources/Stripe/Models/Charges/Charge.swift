//
//  Charge.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

/**
 Charge object
 https://stripe.com/docs/api/curl#charge_object
 */

public struct StripeCharge: StripeModel {
    public var id: String
    public var object: String
    public var amount: Int
    public var amountRefunded: Int?
    public var application: String?
    public var applicationFee: String?
    public var applicationFeeAmount: Int?
    public var balanceTransaction: String?
    public var captured: Bool
    public var created: Date?
    public var currency: StripeCurrency
    public var customer: String?
    public var description: String?
    public var destination: String?
    public var dispute: String?
    public var failureCode: String?
    public var failureMessage: String?
    public var fraudDetails: StripeFraudDetails?
    public var invoice: String?
    public var livemode: Bool?
    public var metadata: [String: String]
    public var onBehalfOf: String?
    public var order: String?
    public var outcome: StripeOutcome?
    public var paid: Bool?
    public var paymentIntent: String?
    public var receiptEmail: String?
    public var receiptNumber: String?
    public var refunded: Bool?
    public var refunds: RefundsList
    public var review: String?
    public var shipping: ShippingLabel?
    public var source: StripeSource?
    public var sourceTransfer: String?
    public var statementDescriptor: String?
    public var status: StripeStatus?
    public var transfer: String?
    public var transferData: StripeChargeTransferData?
    public var transferGroup: String?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case amountRefunded = "amount_refunded"
        case application
        case applicationFee = "application_fee"
        case applicationFeeAmount = "application_fee_amount"
        case balanceTransaction = "balance_transaction"
        case captured
        case created
        case currency
        case customer
        case description
        case destination
        case dispute
        case failureCode = "failure_code"
        case failureMessage = "failure_message"
        case fraudDetails = "fraud_details"
        case invoice
        case livemode
        case metadata
        case onBehalfOf = "on_behalf_of"
        case order
        case outcome
        case paid
        case paymentIntent = "payment_intent"
        case receiptEmail = "receipt_email"
        case receiptNumber = "receipt_number"
        case refunded
        case refunds
        case review
        case shipping
        case source
        case sourceTransfer = "source_transfer"
        case statementDescriptor = "statement_descriptor"
        case status
        case transfer
        case transferData = "transfer_data"
        case transferGroup = "transfer_group"
    }
}

public struct StripeChargeTransferData: StripeModel {
    public var amount: Int?
    public var destination: String?
}
