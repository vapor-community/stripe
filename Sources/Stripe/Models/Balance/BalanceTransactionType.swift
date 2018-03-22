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
    case adjustment
    case applicationFee = "application_fee"
    case applicationFeeRefund = "application_fee_refund"
    case charge
    case payment
    case paymentFailureRefund = "payment_failure_refund"
    case paymentRefund = "payment_refund"
    case refund
    case transfer
    case transferRefund = "transfer_refund"
    case payout
    case payoutCancel = "payout_cancel"
    case payoutFailure = "payout_failure"
    case validation
    case stripeFee = "stripe_fee"
}
