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

public struct StripeRefund: StripeModel {
    public var id: String
    public var object: String
    public var amount: Int?
    public var balanceTransaction: String?
    public var charge: String?
    public var created: Date?
    public var currency: StripeCurrency?
    public var failureBalanceTransaction: String?
    public var failureReason: String?
    public var metadata: [String: String]
    public var reason: RefundReason?
    public var receiptNumber: String?
    public var status: StripeStatus?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case balanceTransaction = "balance_transaction"
        case charge
        case created
        case currency
        case failureBalanceTransaction = "failure_balance_transaction"
        case failureReason = "failure_reason"
        case metadata
        case reason
        case receiptNumber = "receipt_number"
        case status
    }
}
