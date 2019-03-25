//
//  ApplicationFeeRefund.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/17/19.
//

import Vapor
/// `Application Fee Refund` objects allow you to refund an application fee that has previously been created but not yet refunded. Funds will be refunded to the Stripe account from which the fee was originally collected.
public struct StripeApplicationFeeRefund: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Amount, in cents.
    public var amount: Int?
    /// Balance transaction that describes the impact on your account balance.
    public var balanceTransaction: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// ID of the application fee that was refunded.
    public var fee: String?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case balanceTransaction = "balance_transaction"
        case created
        case currency
        case fee
        case metadata
    }
}

public struct StripeApplicationFeeRefundList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeApplicationFeeRefund]?
    
    private enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case url
        case data
    }
}
