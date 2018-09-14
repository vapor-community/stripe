//
//  TransferReversal.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/2/18.
//

import Foundation

/**
 Transfer object
 https://stripe.com/docs/api/curl#transfer_reversal_object
 */

public struct StripeTransferReversal: StripeModel {
    public var id: String
    public var object: String
    public var amount: Int?
    public var balanceTransaction: String?
    public var created: Date?
    public var currency: StripeCurrency?
    public var metadata: [String: String]
    public var transfer: String?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case balanceTransaction = "balance_transaction"
        case created
        case currency
        case metadata
        case transfer
    }
}
