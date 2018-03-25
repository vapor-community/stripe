//
//  OrderReturnRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/25/17.
//
//

import Vapor

public protocol OrderReturnRoutes {
    associatedtype OR: OrderReturn
    associatedtype L: List
    
    func retrieve(order: String) throws -> Future<OR>
    func listAll(filter: [String: Any]?) throws -> Future<L>
}

public struct StripeOrderReturnRoutes: OrderReturnRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    /// Retrieve an order return
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_order_return)
    public func retrieve(order: String) throws -> Future<StripeOrderReturn> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.orderReturns(order).endpoint)
    }
    
    /// List all order returns
    /// [Learn More →](https://stripe.com/docs/api/curl#list_order_returns)
    public func listAll(filter: [String : Any]?) throws -> Future<OrderReturnList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .GET, path: StripeAPIEndpoint.orderReturn.endpoint, query: queryParams)
    }
}
