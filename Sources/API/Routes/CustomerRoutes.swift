//
//  CustomerRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//

import Foundation
import Node
import HTTP
import Models
import Helpers
import Errors

public final class CustomerRoutes {
    
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Create a customer
     Creates a new customer object.
     
     - parameter email:       The Customer’s email address. It’s displayed alongside the customer in your
                              dashboard and can be useful for searching and tracking.
     
     - parameter description: An arbitrary string that you can attach to a customer object. It is displayed 
                              alongside the customer in the dashboard. This will be unset if you POST an 
                              empty value.
     
     - parameter metadata:    A set of key/value pairs that you can attach to a customer object. It can be 
                              useful for storing additional information about the customer in a structured 
                              format. You can unset individual keys if you POST an empty value for that key. 
                              You can clear all keys if you POST an empty value for metadata.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    public func create(email: String, currency: StripeCurrency? = nil, description: String? = nil, metadata: [String : String]? = nil) throws -> StripeRequest<Customer> {
        var body = Node([:])
        
        body["email"] = Node(email)
        
        if let currency = currency {
            body["currency"] = Node(currency.rawValue)
        }
        
        if let description = description {
            body["description"] = Node(description)
        }
        
        if let metadata = metadata {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = try Node(node: value)
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .customers, query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Create a customer
     Creates a new customer object.
     
     - parameter customer: A customer class created with appropiate values set. Any unset parameters (nil) 
                           will unset the value on stripe
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func create(customer: Customer) throws -> StripeRequest<Customer> {
        var body = Node([:])
        
        if let email = customer.email {
            body["email"] = Node(email)
        }
        
        if let description = customer.description {
            body["description"] = Node(description)
        }
        
        if let bussinessVATId = customer.bussinessVATId {
            body["business_vat_id"] = Node(bussinessVATId)
        }
        
        if let defaultSourceId = customer.defaultSourceId {
            body["source"] = Node(defaultSourceId)
        }
        
        if let currency = customer.currency {
            body["currency"] = Node(currency.rawValue)
        }
        
        if let metadata = customer.metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .customers, query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Creats a source for the customer
     
     - parameter customer: The customer object to add the source to
     - parameter account:  A connect account to add the customer to
     - parameter source:   The source token to add to the customer.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    
    public func createSource(for customer: Customer, inAccount account: String?=nil, source: String) throws -> StripeRequest<Customer> {
        let body = try Node(node: ["source": source])
        
        var headers: [HeaderKey: String]?
        
        // Check if we have an account to set it to
        if let account = account {
            headers = ["Stripe-Account": account]
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .customerSources(customer.id), query: [:], body: Body.data(body.formURLEncoded()), headers: headers)
    }
    
    /**
     Creats a source for the customer
     
     - parameter customerId: The customer object to add the source to
     - parameter account:    A connect account to add the customer to
     - parameter source:     The source token to add to the customer.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func createSource(for customerId: String, inAccount account: String?=nil, source: String) throws -> StripeRequest<Customer> {
        let body = try Node(node: ["source": source])
        
        var headers: [HeaderKey: String]?
        
        // Check if we have an account to set it to
        if let account = account {
            headers = ["Stripe-Account": account]
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .customerSources(customerId), query: [:], body: Body.data(body.formURLEncoded()), headers: headers)
    }
    
    /**
     Updates or sets the default source for the customer
     
     - parameter customer: The customer object to add the source to
     - parameter account:  A connect account to add the customer to
     - parameter source:   The source token to add to the customer.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func updateDefaultSource(for customer: Customer, source: String) throws -> StripeRequest<Customer> {
        let body = try Node(node: ["default_source": source])
        return try StripeRequest(client: self.client, method: .post, route: .customer(customer.id), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Updates or sets the default source for the customer
     
     - parameter customerId: The customer object to add the source to
     - parameter account:    A connect account to add the customer to
     - parameter source:     The source token to add to the customer.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func updateDefaultSource(for customerId: String, source: String) throws -> StripeRequest<Customer> {
        let body = try Node(node: ["default_source": source])
        return try StripeRequest(client: self.client, method: .post, route: .customer(customerId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Retrieve a customer
     Retrieves the details of an existing customer. You need only supply the unique customer identifier 
     that was returned upon customer creation.
     
     - parameter customerId: The Customer's ID
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    public func retrieve(customer customerId: String) throws -> StripeRequest<Customer> {
        return try StripeRequest(client: self.client, method: .get, route: .customer(customerId), query: [:], body: nil, headers: nil)
    }
    
    /**
     Update a customer
     Updates the specified customer by setting the values of the parameters passed. Any parameters not 
     provided will be left unchanged. For example, if you pass the source parameter, that becomes the 
     customer’s active source (e.g., a card) to be used for all charges in the future. When you update a 
     customer to a new valid source: for each of the customer’s current subscriptions, if the subscription 
     is in the past_due state, then the latest unpaid, unclosed invoice for the subscription will be retried 
     (note that this retry will not count as an automatic retry, and will not affect the next regularly 
     scheduled payment for the invoice). (Note also that no invoices pertaining to subscriptions in the 
     unpaid state, or invoices pertaining to canceled subscriptions, will be retried as a result of updating 
     the customer’s source.)
     
     This request accepts mostly the same arguments as the customer creation call.
     
     - parameter customer: A customer class created with appropiate values set. Any unset parameters (nil)
     will unset the value on stripe
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func update(customer: Customer, forCustomerId customerId: String) throws -> StripeRequest<Customer> {
        var body = Node([:])
        
        if let email = customer.email {
            body["email"] = Node(email)
        }
        
        if let description = customer.description {
            body["description"] = Node(description)
        }
        
        if let bussinessVATId = customer.bussinessVATId {
            body["business_vat_id"] = Node(bussinessVATId)
        }
        
        if let defaultSourceId = customer.defaultSourceId {
            body["source"] = Node(defaultSourceId)
        }
        
        if let metadata = customer.metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = try Node(node: "\(String(describing: value))")
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .customer(customerId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Delete a customer
     Permanently deletes a customer. It cannot be undone. Also immediately cancels any active subscriptions on the customer.
     
     - parameter customerId: The Customer's ID
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func delete(customer customerId: String) throws -> StripeRequest<DeletedObject> {
        return try StripeRequest(client: self.client, method: .delete, route: .customer(customerId), query: [:], body: nil, headers: nil)
    }
    
    /**
     List all customers
     Returns a list of your customers. The customers are returned sorted by creation date, with the 
     most recent customers appearing first.
     
     - parameter filter: A Filter item to pass query parameters when fetching results
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func listAll(filter: StripeFilter?=nil) throws -> StripeRequest<CustomerList> {
        var query = [String : NodeRepresentable]()
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .customers, query: query, body: nil, headers: nil)
    }
}
