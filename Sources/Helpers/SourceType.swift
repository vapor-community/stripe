//
//  SourceType.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/14/17.
//
//

import Foundation

public enum SourceType: String
{
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
