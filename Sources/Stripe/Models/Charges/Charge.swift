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

public protocol Charge {
    associatedtype L: List
    associatedtype S: Shipping
    associatedtype F: FraudDetails
    associatedtype SRC: Source
    
    var id: String? { get }
    var object: String? { get }
    var amount: Int? { get }
    var amountRefunded: Int? { get }
    var application: String? { get }
    var applicationFee: String? { get }
    var balanceTransactionId: String? { get }
    var isCaptured: Bool? { get }
    var created: Date? { get }
    var currency: StripeCurrency? { get }
    var customerId: String? { get }
    var description: String? { get }
    var destination: String? { get }
    var dispute: String? { get }
    var failureCode: String? { get }
    var failureMessage: String? { get }
    var fraudDetails: F? { get }
    var invoiceId: String? { get }
    var isLive: Bool? { get }
    var metadata: [String: String]? { get }
    var onBehalfOf: String? { get }
    var orderId: String? { get }
    var outcome: StripeOutcome? { get }
    var isPaid: Bool? { get }
    var receiptEmail: String? { get }
    var receiptNumber: String? { get }
    var isRefunded: Bool? { get }
    var refunds: L? { get }
    var review: String? { get }
    var shipping: S? { get }
    var source: SRC? { get }
    var sourceTransfer: String? { get }
    var statementDescriptor: String? { get }
    var status: StripeStatus? { get }
    var transfer: String? { get }
    var transferGroup: String? { get }
}

public struct StripeCharge: Charge, StripeModel {
    public var id: String?
    public var object: String?
    public var amount: Int?
    public var amountRefunded: Int?
    public var application: String?
    public var applicationFee: String?
    public var balanceTransactionId: String?
    public var isCaptured: Bool?
    public var created: Date?
    public var currency: StripeCurrency?
    public var customerId: String?
    public var description: String?
    public var destination: String?
    public var dispute: String?
    public var failureCode: String?
    public var failureMessage: String?
    public var fraudDetails: StripeFraudDetails?
    public var invoiceId: String?
    public var isLive: Bool?
    public var metadata: [String: String]?
    public var onBehalfOf: String?
    public var orderId: String?
    public var outcome: StripeOutcome?
    public var isPaid: Bool?
    public var receiptEmail: String?
    public var receiptNumber: String?
    public var isRefunded: Bool?
    public var refunds: RefundsList?
    public var review: String?
    public var shipping: ShippingLabel?
    public var source: StripeSource?
    public var sourceTransfer: String?
    public var statementDescriptor: String?
    public var status: StripeStatus?
    public var transfer: String?
    public var transferGroup: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case amountRefunded = "amount_refunded"
        case application
        case applicationFee = "application_fee"
        case balanceTransactionId = "balance_transaction"
        case isCaptured
        case created
        case currency
        case customerId
        case description
        case destination
        case dispute
        case failureCode = "failure_code"
        case failureMessage = "failure_message"
        case fraudDetails = "fraud_details"
        case invoiceId = "invoice"
        case isLive = "livemode"
        case metadata
        case onBehalfOf = "on_behalf_of"
        case orderId = "order"
        case outcome
        case isPaid = "paid"
        case receiptEmail = "receipt_email"
        case receiptNumber = "receipt_number"
        case isRefunded = "refunded"
        case refunds
        case review
        case shipping
        case source
        case sourceTransfer = "source_transfer"
        case statementDescriptor = "statement_descriptor"
        case status
        case transfer
        case transferGroup = "transfer_group"
    }
}
