//
//  BalanceTransactionType.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import Foundation

/**
 BalanceTransactionType
 https://stripe.com/docs/api/curl#balance_transaction_object-type
 */

public enum BalanceTransactionType: String, Codable {
    case charge
    case refund
    case adjustment
    case applicationFee
    case applicationFeeRefund
    case transfer
    case payment
    case payout
    case payoutFailure
    
    enum CodingKeys: String, CodingKey {
        case charge
        case refund
        case adjustment
        case applicationFee = "application_fee"
        case applicationFeeRefund = "application_fee_refund"
        case transfer
        case payment
        case payout
        case payoutFailure = "payout_failure"
    }
}
