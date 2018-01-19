//
//  SourceType.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/14/17.
//
//

/**
 Source type 
 https://stripe.com/docs/api/curl#source_object-type
 */

public enum SourceType: String, Codable {
    case card
    case bitcoin
    case threeDSecure
    case giropay
    case sepaDebit
    case ideal
    case sofort
    case bancontact
    case alipay
    case p24
    
    enum CodingKeys: String, CodingKey {
        case card
        case bitcoin
        case threeDSecure = "three_d_secure"
        case giropay
        case sepaDebit = "sepa_debit"
        case ideal
        case sofort
        case bancontact
        case alipay
        case p24
    }
}