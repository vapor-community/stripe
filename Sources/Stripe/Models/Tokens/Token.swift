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

public struct StripeToken: StripeModel {
    public var id: String
    public var object: String
    public var type: TokenType?
    public var clientIp: String?
    public var created: Date?
    public var livemode: Bool?
    public var used: Bool?
    public var card: StripeCard?
    public var bankAccount: StripeBankAccount?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case type
        case clientIp = "client_ip"
        case created
        case livemode
        case used
        case card
        case bankAccount = "bank_account"
    }
}
