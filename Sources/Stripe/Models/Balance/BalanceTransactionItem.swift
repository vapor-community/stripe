//
//  BalanceTransactionItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

/**
 BalanceTransaction object
 https://stripe.com/docs/api/curl#balance_transaction_object
 */

public protocol BalanceTransactionItem {
    associatedtype F: Fee
    
    var id: String? { get }
    var object: String? { get }
    var amount: Int? { get }
    var availableOn: Date? { get }
    var created: Date? { get }
    var currency: StripeCurrency? { get }
    var description: String? { get }
    var fee: Int? { get }
    var fees: [F]? { get }
    var net: Int? { get }
    var source: String? { get }
    var status: StripeStatus? { get }
    var type: BalanceTransactionType? { get }
}

public struct StripeBalanceTransactionItem: BalanceTransactionItem, StripeModel {
    public var id: String?
    public var object: String?
    public var amount: Int?
    public var availableOn: Date?
    public var created: Date?
    public var currency: StripeCurrency?
    public var description: String?
    public var fee: Int?
    public var fees: [StripeFee]?
    public var net: Int?
    public var source: String?
    public var status: StripeStatus?
    public var type: BalanceTransactionType?
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case availableOn = "available_on"
        case created
        case currency
        case description
        case fee
        case fees = "fee_details"
        case net
        case source
        case status
        case type
    }
}
