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

public protocol Transfer {
    associatedtype L: List
    
    var id: String? { get }
    var object: String? { get }
    var amount: Int? { get }
    var amountReversed: Int? { get }
    var balanceTransaction: String? { get }
    var created: Date? { get }
    var currency: StripeCurrency? { get }
    var description: String? { get }
    var destination: String? { get }
    var destinationPayment: String? { get }
    var livemode: Bool? { get }
    var metadata: [String: String]? { get }
    var reversals: L? { get }
    var reversed: Bool? { get }
    var sourceTransaction: String? { get }
    var sourceType: String? { get }
    var transferGroup: String? { get }
}

public struct StripeTransfer: Transfer, StripeModel {
    public var id: String?
    public var object: String?
    public var amount: Int?
    public var amountReversed: Int?
    public var balanceTransaction: String?
    public var created: Date?
    public var currency: StripeCurrency?
    public var description: String?
    public var destination: String?
    public var destinationPayment: String?
    public var livemode: Bool?
    public var metadata: [String : String]?
    public var reversals: TransferReversalList?
    public var reversed: Bool?
    public var sourceTransaction: String?
    public var sourceType: String?
    public var transferGroup: String?
    
    public enum CodingKeys: CodingKey, String {
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
