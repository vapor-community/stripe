//
//  BalanceTransfer.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/14/17.
//
//

/**
 Balance transfer is the body object of available array.
 https://stripe.com/docs/api/curl#balance_object
 */
// TODO: - Use BalanceTransfer SourceTypes enum
public protocol BalanceTransfer {
    var currency: StripeCurrency? { get }
    var amount: Int? { get }
    var sourceTypes: [String: Int]? { get }
}

public struct StripeBalanceTransfer: BalanceTransfer, StripeModel {
    public var currency: StripeCurrency?
    public var amount: Int?
    public var sourceTypes: [String: Int]?
}
