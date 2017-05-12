//
//  TokenRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/12/17.
//
//

import Foundation
import Node
import HTTP
import Models
import Helpers
import Errors

public final class TokenRoutes {
    
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    func cleanNumber(_ number: String) -> String {
        var number = number.replacingOccurrences(of: " ", with: "")
        number = number.replacingOccurrences(of: "-", with: "")
        return number
    }
    
    /**
     Create a card token
     Creates a single use token that wraps the details of a credit card. This token can be used in place of a
     credit card dictionary with any API method. These tokens can only be used once: by creating a new charge 
     object, or attaching them to a customer. In most cases, you should create tokens client-side using Checkout, 
     Elements, or Stripe libraries, instead of using the API.
     
     - parameter cardNumber:      The card number, as a string without any separators.
     
     - parameter expirationMonth: Two digit number representing the card's expiration month.
     
     - parameter expirationYear:  Two or four digit number representing the card's expiration year.
     
     - parameter cvc:             Card security code. Highly recommended to always include this value, 
                                  but it's only required for accounts based in European countries.
     
     - parameter name:            Cardholder's full name.
     
     - parameter customer:        The customer (owned by the application's account) to create a token for.
                                  For use with Stripe Connect only; this can only be used with an OAuth access token 
                                  or Stripe-Account header. For more details, see the shared customers documentation.
     
     - parameter currency:        Required to be able to add the card to an account (in all other cases, 
                                  this parameter is not used). When added to an account, the card 
                                  (which must be a debit card) can be used as a transfer destination for
                                  funds in this currency. Currently, the only supported currency for 
                                  debit card transfers is `usd`. MANAGED ACCOUNTS ONLY
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    func create(cardNumber: String, expirationMonth: Int, expirationYear: Int, cvc: Int, name: String?, customer: String? = nil, currency: StripeCurrency? = nil) throws -> StripeRequest<Token> {
        var body = Node([:])
        
        body["card[number]"] = Node(self.cleanNumber(cardNumber))
        body["card[exp_month]"] = Node(expirationMonth)
        body["card[exp_year]"] = Node(expirationYear)
        body["card[cvc]"] = Node(cvc)
        
        if let name = name {
            body["card[name]"] = Node(name)
        }
        
        if let customer = customer {
            body["card[customer]"] = Node(customer)
        }
        
        if let currency = currency {
            body["card[currency]"] = Node(currency.rawValue)
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .tokens, body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Retrieve a token
     Retrieves the token with the given ID.
     
     - parameter token: The ID of the desired token.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    func retrieve(_ token: String) throws -> StripeRequest<Token> {
        return try StripeRequest(client: self.client, route: .token(token))
    }

}
