//
//  OrderReturnRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/25/17.
//
//

import Foundation
import Node
import Models
import Helpers
import HTTP

public final class OrderReturnRoutes {
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    public func retrieve(orderReturn orderReturnId: String) throws -> StripeRequest<OrderReturn> {
        return try StripeRequest(client: self.client, method: .get, route: .orderReturns(orderReturnId), query: [:], body: nil, headers: nil)
    }
    
    public func listAll(filter: StripeFilter? = nil) throws -> StripeRequest<OrderReturnList> {
        var query = [String : NodeRepresentable]()
        
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .orderReturn, query: query, body: nil, headers: nil)
    }
}
