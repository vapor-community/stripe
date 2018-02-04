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
    var feeDetails: [F]? { get }
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
    public var feeDetails: [StripeFee]?
    public var net: Int?
    public var source: String?
    public var status: StripeStatus?
    public var type: BalanceTransactionType?
}
