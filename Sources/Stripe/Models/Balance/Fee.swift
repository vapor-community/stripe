//
//  Fee.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Vapor

/**
 Fee
 https://stripe.com/docs/api/curl#balance_transaction_object-fee_details
 */

public struct StripeFee: StripeModel {
    public var amount: Int?
    public var currency: StripeCurrency?
    public var description: String?
    public var type: ActionType?
}
