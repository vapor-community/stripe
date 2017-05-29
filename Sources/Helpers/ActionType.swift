//
//  ActionType.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

public enum ActionType: String {
    case charge = "charge"
    case stripeFee = "stripe_fee"
    
    // Payment type
    case card = "card"
    case bitcoin = "bitcoin"
    case threeDSecure = "three_d_secure"
    case giropay = "giropay"
    case sepaDebit = "sepa_debit"
    case ideal = "ideal"
    case sofort = "sofort"
    case bancontact = "bancontact"
    
    case none = "none"
}
