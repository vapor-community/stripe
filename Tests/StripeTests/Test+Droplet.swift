//
//  Test+Droplet.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import XCTest
import Vapor
import Stripe

let TestTransactionID = "txn_TRANSACTION_ID" // Used for fetching a specific Transaction in the history
let TestChargeSourceTokenID = "tok_PAYMENT_TOKEN_ID" // Used for creating charges
let TestChargeID = "ch_CHARGE_ID" // Used for fetching a specific charge

extension XCTestCase {
    func makeDroplet() throws -> Droplet {
        let config = Config([
            "stripe": [
                "apiKey": "API_KEY" // Add your own API Key for tests
            ],
        ])
        let drop = try Droplet(config: config)
        try drop.addProvider(Stripe.Provider.self)
        return drop
    }
}
