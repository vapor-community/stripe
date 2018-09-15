//
//  Payout.swift
//  Async
//
//  Created by Andrew Edwards on 8/20/18.
//

import Foundation

/**
 Payout object
 https://stripe.com/docs/api/curl#payout_object
 */

public struct StripePayout: StripeModel {
    public var id: String
    public var object: String
    public var amount: Int?
    public var arrivalDate: Date?
    public var automatic: Bool?
    public var balanceTransaction: String?
    public var created: Date?
    public var currency: StripeCurrency?
    public var description: String?
    public var destination: String?
    public var failureBalanceTransaction: String?
    public var failureCode: StripePayoutFailureCode?
    public var failureMessage: String?
    public var livemode: Bool?
    public var metadata: [String: String]
    public var method: StripePayoutMethod?
    public var sourceType: StripePayoutSourceType?
    public var statementDescriptor: String?
    public var status: StripePayoutStatus?
    public var type: StripePayoutType?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case arrivalDate = "arrival_date"
        case automatic
        case balanceTransaction = "balance_transaction"
        case created
        case currency
        case description
        case destination
        case failureBalanceTransaction = "failure_balance_transaction"
        case failureCode = "failure_code"
        case failureMessage = "failure_message"
        case livemode
        case metadata
        case method
        case sourceType = "source_type"
        case statementDescriptor = "statement_descriptor"
        case status
        case type
    }
}
