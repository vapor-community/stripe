//
//  Transfer.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/2/18.
//

import Foundation

/**
 Transfer object
 https://stripe.com/docs/api/curl#transfer_object
 */

public struct StripeTransfer: StripeModel {
    public var id: String
    public var object: String
    public var amount: Int?
    public var amountReversed: Int?
    public var balanceTransaction: String?
    public var created: Date?
    public var currency: StripeCurrency?
    public var description: String?
    public var destination: String?
    public var destinationPayment: String?
    public var livemode: Bool?
    public var metadata: [String: String]
    public var reversals: TransferReversalList?
    public var reversed: Bool?
    public var sourceTransaction: String?
    public var sourceType: String?
    public var transferGroup: String?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case amountReversed = "amount_reversed"
        case balanceTransaction = "balance_transaction"
        case created
        case currency
        case description
        case destination
        case destinationPayment = "destination_payment"
        case livemode
        case metadata
        case reversals
        case reversed
        case sourceTransaction = "source_transaction"
        case sourceType = "source_type"
        case transferGroup = "transfer_group"
    }
}
