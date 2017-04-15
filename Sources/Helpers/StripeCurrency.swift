//
//  Currency.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/14/17.
//
//

public enum StripeCurrency: String {
    case aud = "aud"
    case cad = "cad"
    case dkk = "dkk"
    case eur = "eur"
    case gpd = "gpd"
    case jpy = "jpy"
    case nok = "nok"
    case usd = "usd"
    case sek = "sek"
    case sgd = "sgd"
    
    var description: String {
        return self.rawValue.uppercased()
    }
}
