//
//  RefundItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

/**
 Refund object
 https://stripe.com/docs/api/curl#refunds
 */

public protocol Refund {
    var id: String? { get }
    var object: String? { get }
    var amount: Int? { get }
    var balanceTransaction: String? { get }
    var charge: String? { get }
    var created: Date? { get }
    var currency: StripeCurrency? { get }
    var description: String? { get }
    var metadata: [String: String]? { get }
    var reason: RefundReason? { get }
    var receiptNumber: String? { get }
    var status: StripeStatus? { get }
}

public struct StripeRefund: Refund, StripeModel {
    public var id: String?
    public var object: String?
    public var amount: Int?
    public var balanceTransaction: String?
    public var charge: String?
    public var created: Date?
    public var currency: StripeCurrency?
    public var description: String?
    public var metadata: [String: String]?
    public var reason: RefundReason?
    public var receiptNumber: String?
    public var status: StripeStatus?
    
    public enum CodingKeys: CodingKey, String {
        case id
        case object
        case amount
        case balanceTransaction = "balance_transaction"
        case charge
        case created
        case currency
        case description
        case metadata
        case reason
        case receiptNumber = "receipt_number"
        case status
    }
}
