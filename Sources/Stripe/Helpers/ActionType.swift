//
//  ActionType.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

public enum ActionType: String, Codable {
    case applicationFee = "application_fee"
    case stripeFee = "stripe_fee"
    case tax
}
