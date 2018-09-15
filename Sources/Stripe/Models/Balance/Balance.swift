//
//  Balance.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

/**
 Balance object
 https://stripe.com/docs/api/curl#balance_object
 */

public struct StripeBalance: StripeModel {
    public var object: String
    public var available: [StripeBalanceTransfer]?
    public var connectReserved: [StripeBalanceTransfer]?
    public var livemode: Bool?
    public var pending: [StripeBalanceTransfer]?
    
    public enum CodingKeys: String, CodingKey {
        case object
        case available
        case connectReserved = "connect_reserved"
        case livemode
        case pending
    }
}
