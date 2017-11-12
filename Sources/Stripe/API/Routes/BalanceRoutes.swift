//
//  BalanceRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Node

open class BalanceRoutes {
    
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Retrieve balance
     Retrieves the current account balance, based on the authentication that was used to make the request.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    public func retrieveBalance() throws -> StripeRequest<Balance> {
        return try StripeRequest(client: self.client, method: .get, route: .balance, query: [:], body: nil, headers: nil)
    }
    
    /**
     Retrieve a balance transaction
     Retrieves the balance transaction with the given ID.
     
     - parameter transactionId: The ID of the desired balance transaction (as found on any API object that affects the balance, e.g. a charge or transfer).
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func retrieveBalance(forTransaction transactionId: String) throws -> StripeRequest<BalanceTransactionItem> {
        return try StripeRequest(client: self.client, method: .get, route: .balanceHistoryTransaction(transactionId), query: [:], body: nil, headers: nil)
    }
    
    /**
     List all balance history
     Returns a list of transactions that have contributed to the Stripe account balance (e.g., charges, transfers, and so forth). 
     The transactions are returned in sorted order, with the most recent transactions appearing first.
     
     - parameter filter: A Filter item to pass query parameters when fetching results
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func history(forFilter filter: StripeFilter? = nil) throws -> StripeRequest<BalanceHistoryList> {
        var query = [String : NodeRepresentable]()
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .balanceHistory, query: query, body: nil, headers: nil)
    }
}
