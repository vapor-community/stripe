//
//  Fee.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor

/**
 Fee
 https://stripe.com/docs/api/curl#balance_transaction_object-fee_details
 */

public protocol Fee {
    var amount: Int? { get }
    var currency: StripeCurrency? { get }
    var description: String? { get }
    var type: ActionType? { get }
}

public struct StripeFee: Fee, StripeModelProtocol {
    public var amount: Int?
    public var currency: StripeCurrency?
    public var description: String?
    public var type: ActionType?
}
