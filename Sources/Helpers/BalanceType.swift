//
//  BalanceType.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import Foundation

public enum BalanceType: String {
    case charge = "charge"
    case refund = "refund"
    case adjustment = "adjustment"
    case applicationFee = "application_fee"
    case applicationFeeRefund = "application_fee_refund"
    case transfer = "transfer"
    case payment = "payment"
    case payout = "payout"
    case payoutFailure = "payout_failure"
}
