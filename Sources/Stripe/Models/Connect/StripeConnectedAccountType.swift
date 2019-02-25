//
//  ConnectedAccountType.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/9/17.
//
//

// https://stripe.com/docs/api/curl#account_object-type
public enum StripeConnectAccountType: String, Codable {
    case custom
    case standard
}

public enum StripeConnectAccountBusinessType: String, Codable {
    case individual
    case company
}
