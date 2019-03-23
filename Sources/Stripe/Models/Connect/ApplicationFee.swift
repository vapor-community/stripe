//
//  ApplicationFee.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/16/19.
//

import Vapor
/// When you collect a transaction fee on top of a charge made for your user (using [Connect](https://stripe.com/docs/connect) ), an `Application Fee` object is created in your account. You can list, retrieve, and refund application fees. For details, see [Collecting application fees](https://stripe.com/docs/connect/direct-charges#collecting-fees). [Learn More →](https://stripe.com/docs/api/application_fees)
public struct StripeApplicationFee: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// ID of the Stripe account this fee was taken from.
    public var account: String?
    /// Amount earned, in cents.
    public var amount: Int?
    /// Amount in cents refunded (can be less than the amount attribute on the fee if a partial refund was issued)
    public var amountRefunded: Int?
    /// ID of the Connect application that earned the fee.
    public var application: String?
    /// Balance transaction that describes the impact of this collected application fee on your account balance (not including refunds).
    public var balanceTransaction: String?
    /// ID of the charge that the application fee was taken from.
    public var charge: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// ID of the corresponding charge on the platform account, if this fee was the result of a charge using the destination parameter.
    public var originatingTransaction: String?
    /// Whether the fee has been fully refunded. If the fee is only partially refunded, this attribute will still be false.
    public var refunded: Bool?
    /// A list of refunds that have been applied to the fee.
    public var refunds: StripeApplicationFeeRefundList?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case object
        case account
        case amount
        case amountRefunded = "amount_refunded"
        case application
        case balanceTransaction = "balance_transaction"
        case charge
        case created
        case currency
        case livemode
        case originatingTransaction = "originating_transaction"
        case refunded
        case refunds
    }
}

public struct StripeApplicationFeeList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeApplicationFee]?
    
    private enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case url
        case data
    }
}
