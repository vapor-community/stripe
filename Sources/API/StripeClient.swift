//
//  Stripe.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Vapor

public class StripeClient {

    public let apiKey: String

    public var balance: BalanceRoutes!

    public init(apiKey: String) throws {
        self.apiKey = apiKey
    }

    public func initializeRoutes() {
        self.balance = BalanceRoutes(client: self)
    }

}
