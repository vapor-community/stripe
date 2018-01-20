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

public protocol Balance {
    associatedtype BT: BalanceTransfer
    
    var object: String? { get }
    var available: [BT]? { get }
    var connectReserved: [BT]? { get }
    var isLive: Bool? { get }
    var pending: [BT]? { get }
}

public struct StripeBalance: Balance, StripeModel {
    public var object: String?
    public var available: [StripeBalanceTransfer]?
    public var connectReserved: [StripeBalanceTransfer]?
    public var isLive: Bool?
    public var pending: [StripeBalanceTransfer]?
    
    enum CodingKeys: String, CodingKey {
        case object
        case available
        case connectReserved = "connected_reserved"
        case isLive = "livemode"
        case pending
    }
}
