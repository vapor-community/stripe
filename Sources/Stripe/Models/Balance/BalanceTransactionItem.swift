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

public struct StripeBalanceTransactionItem: StripeModel {
    public var id: String
    public var object: String
    public var amount: Int?
    public var availableOn: Date?
    public var created: Date?
    public var currency: StripeCurrency?
    public var exchangeRate: Decimal?
    public var description: String?
    public var fee: Int?
    public var feeDetails: [StripeFee]?
    public var net: Int?
    public var source: String?
    public var status: StripeStatus?
    public var type: BalanceTransactionType?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case availableOn = "available_on"
        case created
        case currency
        case exchangeRate = "exchange_rate"
        case description
        case fee
        case feeDetails = "fee_details"
        case net
        case source
        case status
        case type
    }
}
