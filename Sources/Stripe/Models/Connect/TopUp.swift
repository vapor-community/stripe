//
//  TopUp.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/24/19.
//

import Vapor
/// The top-up object [see here](https://stripe.com/docs/api/topups/object)
public struct StripeTopUp: StripeModel {
    /// Unique identifier for the object.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// Amount transferred.
    public var amount: Int?
    /// ID of the balance transaction that describes the impact of this top-up on your account balance. May not be specified depending on status of top-up.
    public var balanceTransaction: String?
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public var created: Date?
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public var currency: StripeCurrency?
    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public var description: String?
    /// Date the funds are expected to arrive in your Stripe account for payouts. This factors in delays like weekends or bank holidays. May not be specified depending on status of top-up.
    public var expectedAvailabilityDate: Date?
    /// Error code explaining reason for top-up failure if available (see [the errors section](https://stripe.com/docs/api#errors) for a list of codes).
    public var failureCode: String?
    /// Message to user further explaining reason for top-up failure if available.
    public var failureMessage: String?
    /// Has the value true if the object exists in live mode or the value false if the object exists in test mode.
    public var livemode: Bool?
    /// Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format.
    public var metadata: [String: String]?
    /// For most Stripe users, the source of every top-up is a bank account. This hash is then the [source object](https://stripe.com/docs/api/topups/object#source_object) describing that bank account.
    public var source: StripeSource?
    /// Extra information about a top-up. This will appear on your source’s bank statement. It must contain at least one letter.
    public var statementDescriptor: String?
    /// The status of the top-up is either `canceled`, `failed`, `pending`, `reversed`, or `succeeded`.
    public var status: StripeTopUpStatus?
    /// A string that identifies this top-up as part of a group.
    public var transferGroup: String?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case balanceTransaction = "balance_transaction"
        case created
        case currency
        case description
        case expectedAvailabilityDate = "expected_availability_date"
        case failureCode = "failure_code"
        case failureMessage = "failure_message"
        case livemode
        case metadata
        case source
        case statementDescriptor = "statement_descriptor"
        case status
        case transferGroup = "transfer_group"
    }
}

public enum StripeTopUpStatus: String, StripeModel {
    case canceled
    case failed
    case pending
    case reversed
    case succeeded
}

public struct StripeTopUpList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeTopUp]?
    
    private enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case url
        case data
    }
}
