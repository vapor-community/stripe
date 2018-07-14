//
//  BalanceRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Vapor

public protocol BalanceRoutes {
    func retrieve() throws -> Future<StripeBalance>
    func retrieve(forTransaction: String) throws -> Future<StripeBalanceTransactionItem>
    func listAll(filter: [String: Any]?) throws -> Future<BalanceHistoryList>
}

extension BalanceRoutes {
    public func retrieve() throws -> Future<StripeBalance> {
        return try retrieve()
    }
    
    public func retrieve(forTransaction: String) throws -> Future<StripeBalanceTransactionItem> {
        return try retrieve(forTransaction: forTransaction)
    }
    
    public func listAll(filter: [String: Any]? = nil) throws -> Future<BalanceHistoryList> {
        return try listAll(filter: filter)
    }
}

public struct StripeBalanceRoutes: BalanceRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    /// Retrieve balance
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_balance)
    public func retrieve() throws -> Future<StripeBalance> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.balance.endpoint)
    }
    
    /// Retrieve a balance transaction
    /// [Learn More →](https://stripe.com/docs/api/curl#balance_transaction_retrieve)
    public func retrieve(forTransaction transactionId: String) throws -> Future<StripeBalanceTransactionItem> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.balanceHistoryTransaction(transactionId).endpoint)
    }
    
    /// List all balance history
    /// [Learn More →](https://stripe.com/docs/api/curl#balance_history)
    public func listAll(filter: [String: Any]?) throws -> Future<BalanceHistoryList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return try request.send(method: .GET, path: StripeAPIEndpoint.account.endpoint, query: queryParams)
    }
}
