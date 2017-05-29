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
                "apiKey": "" // Add your own API Key for tests
            ],
        ])
        try config.addProvider(Stripe.Provider.self)
        return try Droplet(config: config)
    }
}
