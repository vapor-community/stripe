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
    var balanceTransaction: String? { get }
    var captured: Bool? { get }
    var created: Date? { get }
    var currency: StripeCurrency? { get }
    var customer: String? { get }
    var description: String? { get }
    var destination: String? { get }
    var dispute: String? { get }
    var failureCode: String? { get }
    var failureMessage: String? { get }
    var fraudDetails: F? { get }
    var invoice: String? { get }
    var livemode: Bool? { get }
    var metadata: [String: String]? { get }
    var onBehalfOf: String? { get }
    var order: String? { get }
    var outcome: StripeOutcome? { get }
    var paid: Bool? { get }
    var receiptEmail: String? { get }
    var receiptNumber: String? { get }
    var refunded: Bool? { get }
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
    public var balanceTransaction: String?
    public var captured: Bool?
    public var created: Date?
    public var currency: StripeCurrency?
    public var customer: String?
    public var description: String?
    public var destination: String?
    public var dispute: String?
    public var failureCode: String?
    public var failureMessage: String?
    public var fraudDetails: StripeFraudDetails?
    public var invoice: String?
    public var livemode: Bool?
    public var metadata: [String: String]?
    public var onBehalfOf: String?
    public var order: String?
    public var outcome: StripeOutcome?
    public var paid: Bool?
    public var receiptEmail: String?
    public var receiptNumber: String?
    public var refunded: Bool?
    public var refunds: RefundsList?
    public var review: String?
    public var shipping: ShippingLabel?
    public var source: StripeSource?
    public var sourceTransfer: String?
    public var statementDescriptor: String?
    public var status: StripeStatus?
    public var transfer: String?
    public var transferGroup: String?
}
