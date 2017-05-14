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
let TestTransactionID = "txn_1A9KJiJm6xi4tXu1EkbD0ZEC"

// Used for creating charges
let TestChargeSourceTokenID = "tok_1A9M61Jm6xi4tXu1sSQMnsxp"

// Used for fetching a specific charge
let TestChargeID = "ch_1A9M5oJm6xi4tXu1iWO7wxMy"

// Used for fetching a specific customer
let TestCustomerID = "cus_AVqRAm2Gv8EMyd"

// Used for token testing
let TestTokenID = "tok_1AIiMpJm6xi4tXu1hoimk73q"

// Used for refund testing
let TestRefundID = "re_1AJ4FFJm6xi4tXu1YFFB9N7P"

extension XCTestCase {
    func makeDroplet() throws -> Droplet {
        let config = Config([
            "stripe": [
                "apiKey": "sk_test_Pb8SpX80t1XhJengpQ3oE67H" // Add your own API Key for tests
            ],
        ])
        try config.addProvider(Stripe.Provider.self)
        return try Droplet(config: config)
    }
}
