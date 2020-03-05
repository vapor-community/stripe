//
//  TokenType.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/17/18.
//

import Foundation

public enum TokenType: String, Codable {
    case account
    case bankAccount = "bank_account"
    case card
    case pii
}

