//
//  BalanceRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Foundation
import Models

public final class BalanceRoutes {
    
    var client: StripeClient!
    
    init(client: StripeClient) {
        self.client = client
    }
    
    public func test() throws -> StripeRequest<Balance> {
        return try StripeRequest(client: self.client, method: .get, route: "https://api.stripe.com/v1/charges", query: [:], body: nil, headers: nil)
    }
    
}
