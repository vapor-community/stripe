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
