//
//  BalanceRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Foundation
import Node
import Models

public final class BalanceRoutes {
    
    var client: StripeClient!
    
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
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func retrieveBalance(forTransaction transactionId: String) throws -> StripeRequest<BalanceTransactionItem> {
        return try StripeRequest(client: self.client, method: .get, route: .balanceHistoryTransaction(transactionId), query: [:], body: nil, headers: nil)
    }
    
    /**
     List all balance history
     Returns a list of transactions that have contributed to the Stripe account balance (e.g., charges, transfers, and so forth). 
     The transactions are returned in sorted order, with the most recent transactions appearing first.
     
     - parameter limit:       Limit the amount of data returned.
     - parameter availableOn: A filter on the list based on the object available_on field.
     - parameter created:     A  filter on the list based on the object created field.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func history(limit: Int?=nil, availableOn: Date?=nil, created: Date?=nil) throws -> StripeRequest<BalanceHistoryList> {
        var query = [String : NodeRepresentable]()
        if let limit = limit {
            query["limit"] = limit
        }
        
        if let availableOn = availableOn {
            query["available_on"] = availableOn.timeIntervalSince1970
        }
        
        if let created = created {
            query["created"] = created.timeIntervalSince1970
        }
        
        return try StripeRequest(client: self.client, method: .get, route: .balanceHistory, query: query, body: nil, headers: nil)
    }
    
}
