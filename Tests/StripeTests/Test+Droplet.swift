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
                "apiKey": "sk_test_Wxn8UzIs9dkIR4qJYAtHhvY8" // Add your own API Key for tests
            ],
        ])
        try config.addProvider(Stripe.Provider.self)
        return try Droplet(config: config)
    }
}

extension Data {
    var base64UrlEncodedString: String {
        return base64EncodedString()
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "/", with: "")
    }
    
    var base64String: String {
        return self.makeBytes().base64Encoded.makeString()
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "/", with: "")
    }
}
