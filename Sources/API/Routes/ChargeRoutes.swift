//
//  ChargeRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import Foundation
import Node
import HTTP
import Models
import Helpers

public enum ChargeType {
    /**
     A card or token id
    */
    case source(String)
    
    /**
     A customer id to charge
     */
    case customer(String)
}

public final class ChargeRoutes {
    
    var client: StripeClient!
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Create a Charge
     To charge a credit card, you create a charge object. If your API key is in test mode, the supplied payment source 
     (e.g., card or Bitcoin receiver) won't actually be charged, though everything else will occur as if in live mode. 
     (Stripe assumes that the charge would have completed successfully).
     
     - parameter amount:      The payment amount in cents
     - parameter currency:    The currency in which the charge will be under
     - parameter type:        The charge type. Either source (card id or token id) or customer (a customer id to charge)
     - parameter description: An optional description for charges.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func create(amount: Int, in currency: StripeCurrency, for type: ChargeType, description: String?=nil) throws -> StripeRequest<Charge> {
        return try self.create(amount: amount, in: currency, for: type, withFee: nil, toAccount: nil, description: description)
    }
    
    /**
     Create a Charge
     To charge a credit card, you create a charge object. If your API key is in test mode, the supplied payment source
     (e.g., card or Bitcoin receiver) won't actually be charged, though everything else will occur as if in live mode.
     (Stripe assumes that the charge would have completed successfully).
     
     NOTE: Accounts and Fees are only applicable to connected accounts
     
     - parameter amount:      The payment amount in cents
     - parameter currency:    The currency in which the charge will be under
     - parameter type:        The charge type. Either source (card id or token id) or customer (a customer id to charge)
     - parameter fee:         A fee to charge if you are using connected accounts (Must be in cents)
     - parameter account:     The account id which the payment would be sent to.
     - parameter description: An optional description for charges.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func create(amount: Int, in currency: StripeCurrency, for type: ChargeType, withFee fee: Int?, toAccount account: String?, description: String?=nil) throws -> StripeRequest<Charge> {
        // Setup our params
        var body: [String : Any] = [
            "amount": amount,
            "currency": currency.rawValue,
        ]
        switch type {
        case .source(let id): body["source"] = id
        case .customer(let id): body["customer"] = id
        }
        
        if let description = description {
            body["description"] = description
        }
        
        // Create the headers
        var headers: [HeaderKey : String]?
        if let fee = fee, let account = account {
            body["application_fee"] = fee
            headers = [
                StripeHeader.Account: account
            ]
        }
        
        // Create the body node
        let node = try Node(node: body)
        
        return try StripeRequest(client: self.client, method: .post, route: .charges, query: [:], body: Body.data(node.formURLEncoded()), headers: headers)
    }
    
    /**
     Retrieve a charge
     Retrieves the details of a charge that has previously been created. Supply the unique charge ID that was 
     returned from your previous request, and Stripe will return the corresponding charge information. The same 
     information is returned when creating or refunding the charge.
     
     - parameter charge: The chargeId is the ID of the charge
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func retrieve(charge chargeId: String) throws -> StripeRequest<Charge> {
        return try StripeRequest(client: self.client, method: .get, route: .charge(chargeId), query: [:], body: nil, headers: nil)
    }
    
    /**
     List all Charges
     Returns a list of charges you’ve previously created. The charges are returned in sorted order, with the most 
     recent charges appearing first.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func listAll() throws -> StripeRequest<Charge> {
        return try StripeRequest(client: self.client, method: .get, route: .charges, query: [:], body: nil, headers: nil)
    }

}
