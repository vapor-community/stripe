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

// Used for fetching a specific Transaction in the history
let TestTransactionID = "txn_TRANSACTION_ID"

// Used for creating charges
let TestChargeSourceTokenID = "tok_TOKEN_ID"

// Used for fetching a specific charge
let TestChargeID = "ch_CHARGE_ID"

// Used for fetching a specific customer
let TestCustomerID = "cus_CUSTOMER_ID"

// Used for token testing
let TestTokenID = "tok_TOKEN_ID"

extension XCTestCase {
    func makeDroplet() throws -> Droplet {
        let config = Config([
            "stripe": [
                "apiKey": "API_KEY" // Add your own API Key for tests
            ],
        ])
        try config.addProvider(Stripe.Provider.self)
        return try Droplet(config: config)
    }
}
