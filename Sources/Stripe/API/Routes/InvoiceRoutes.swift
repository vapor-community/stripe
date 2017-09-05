//
//  InvoiceRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/4/17.
//
//

import Foundation
import Node
import HTTP

public final class InvoiceRoutes {
    
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     If you need to invoice your customer outside the regular billing cycle, you can create an invoice that pulls in all 
     pending invoice items, including prorations. The customer’s billing cycle and regular subscription won’t be affected.
     
     Once you create the invoice, Stripe will attempt to collect payment according to your subscriptions settings, 
     though you can choose to pay it right away.
     
     - parameter customer:            The ID of the customer to attach the invoice to
     - parameter subscription:        The ID of the subscription to invoice. If not set, the created invoice will include all 
                                      pending invoice items for the customer. If set, the created invoice will exclude pending 
                                      invoice items that pertain to other subscriptions.
     - parameter fee:                 A fee to charge if you are using connected accounts (Must be in cents)
     - parameter account:             The account to transfer the fee to
     - parameter description:         A description for the invoice
     - parameter metadata:            Aditional metadata info
     - parameter taxPercent:          The percent tax rate applied to the invoice, represented as a decimal number.
     - parameter statementDescriptor: Extra information about a charge for the customer’s credit card statement.
     */
    
    public func create(forCustomer customer: String, subscription: String? = nil, withFee fee: Int? = nil, toAccount account: String? = nil, description: String? = nil, metadata: Node? = nil, taxPercent: Double? = nil, statementDescriptor: String? = nil) throws -> StripeRequest<Invoice> {
        var body = Node([:])
        // Create the headers
        var headers: [HeaderKey : String]?
        if let account = account {
            headers = [
                StripeHeader.Account: account
            ]
            
            if let fee = fee {
                body["application_fee"] = Node(fee)
            }
        }
        
        body["customer"] = Node(customer)
        
        if let subscription = subscription {
            body["subscription"] = Node(subscription)
        }
        
        if let description = description {
            body["description"] = Node(description)
        }
        
        if let taxPercent = taxPercent {
            body["description"] = Node(taxPercent)
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = Node(statementDescriptor)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .tokens, body: Body.data(body.formURLEncoded()), headers: headers)
    }
    
    
    
}
