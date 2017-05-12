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

    public private(set) var balance: BalanceRoutes!
    public private(set) var charge: ChargeRoutes!
    public private(set) var customer: CustomerRoutes!
    public private(set) var tokens: TokenRoutes!

    public init(apiKey: String) throws {
        self.apiKey = apiKey
    }

    public func initializeRoutes() {
        self.balance = BalanceRoutes(client: self)
        self.charge = ChargeRoutes(client: self)
        self.customer = CustomerRoutes(client: self)
        self.tokens = TokenRoutes(client: self)
    }

}
