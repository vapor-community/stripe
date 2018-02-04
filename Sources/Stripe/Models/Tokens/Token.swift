//
//  Token.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/23/17.
//
//

import Foundation

/**
 Token object
 https://stripe.com/docs/api/curl#token_object
 */

public protocol Token {
    associatedtype C: Card
    associatedtype B: BankAccount
    
    var id: String? { get }
    var object: String? { get }
    var type: String? { get }
    var clientIp: String? { get }
    var created: Date? { get }
    var livemode: Bool? { get }
    var used: Bool? { get }
    var card: C? { get }
    var bankAccount: B? { get }
}

public struct StripeToken: Token, StripeModel {
    public var id: String?
    public var object: String?
    public var type: String?
    public var clientIp: String?
    public var created: Date?
    public var livemode: Bool?
    public var used: Bool?
    public var card: StripeCard?
    public var bankAccount: StripeBankAccount?
}
