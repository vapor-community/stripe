//
//  ActionType.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

public enum ActionType: String, Codable {
    case charge
    case stripeFee
    case none
    
    enum CodingKeys: String, CodingKey {
        case charge
        case stripeFee = "stripe_fee"
        case none
    }
}
