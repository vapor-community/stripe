//
//  CustomerRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//

import Vapor

public protocol CustomerRoutes {
    associatedtype C: Customer
    associatedtype SH: Shipping
    associatedtype DO: DeletedObject
    associatedtype L: List
    associatedtype SRC: Source
    associatedtype BNK: BankAccount
    associatedtype CRD: Card
    
    func create(accountBalance: Int?, businessVatId: String?, coupon: String?, defaultSource: String?, description: String?, email: String?, metadata: [String: String]?, shipping: SH?, source: Any?) throws -> Future<C>
    func retrieve(customer: String) throws -> Future<C>
    func update(customer: String, accountBalance: Int?, businessVatId: String?, coupon: String?, defaultSource: String?, description: String?, email: String?, metadata: [String: String]?, shipping: SH?, source: Any?) throws -> Future<C>
    func delete(customer: String) throws -> Future<DO>
    func listAll(filter: [String: Any]?) throws -> Future<L>
    func addNewSource(customer: String, source: String, toConnectedAccount: String?) throws -> Future<SRC>
    func addNewBankAccountSource(customer: String, source: Any, toConnectedAccount: String?, metadata: [String: String]?) throws -> Future<BNK>
    func addNewCardSource(customer: String, source: Any, toConnectedAccount: String?, metadata: [String : String]?) throws -> Future<CRD>
    func deleteSource(customer: String, source: String) throws -> Future<SRC>
}

public struct StripeCustomerRoutes<SR: StripeRequest>: CustomerRoutes {
    private let request: SR
    
    init(request: SR) {
        self.request = request
    }
    
    /// Create a customer
    /// [Learn More →](https://stripe.com/docs/api/curl#create_customer)
    public func create(accountBalance: Int? = nil,
                       businessVatId: String? = nil,
                       coupon: String? = nil,
                       defaultSource: String? = nil,
                       description: String? = nil,
                       email: String? = nil,
                       metadata: [String: String]? = nil,
                       shipping: ShippingLabel? = nil,
                       source: Any? = nil) throws -> Future<StripeCustomer> {
        var body: [String: Any] = [:]
        
        if let accountBalance = accountBalance {
            body["account_balance"] = accountBalance
        }
        
        if let businessVatId = businessVatId {
            body["business_vat_id"] = businessVatId
        }
        
        if let coupon = coupon {
            body["coupon"] = coupon
        }
        
        if let defaultSource = defaultSource {
            body["default_source"] = defaultSource
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let shipping = shipping {
            try shipping.toEncodedDictionary().forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let tokenSource = source as? String {
            body["source"] = tokenSource
        }
        
        if let cardDictionarySource = source as? [String: Any] {
            cardDictionarySource.forEach { body["source[\($0)]"] = $1 }
        }
        
        return try request.send(method: .post, path: StripeAPIEndpoint.customers.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve customer
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_customer)
    public func retrieve(customer: String) throws -> Future<StripeCustomer> {
        return try request.send(method: .get, path: StripeAPIEndpoint.customer(customer).endpoint)
    }
    
    /// Update customer
    /// [Learn More →](https://stripe.com/docs/api/curl#update_customer)
    public func update(customer: String,
                       accountBalance: Int? = nil,
                       businessVatId: String? = nil,
                       coupon: String? = nil,
                       defaultSource: String? = nil,
                       description: String? = nil,
                       email: String? = nil,
                       metadata: [String: String]? = nil,
                       shipping: ShippingLabel? = nil,
                       source: Any? = nil) throws -> Future<StripeCustomer> {
        var body: [String: Any] = [:]
        
        if let accountBalance = accountBalance {
            body["account_balance"] = accountBalance
        }
        
        if let businessVatId = businessVatId {
            body["business_vat_id"] = businessVatId
        }
        
        if let coupon = coupon {
            body["coupon"] = coupon
        }
        
        if let defaultSource = defaultSource {
            body["default_source"] = defaultSource
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let shipping = shipping {
            try shipping.toEncodedDictionary().forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let tokenSource = source as? String {
            body["source"] = tokenSource
        }
        
        if let cardDictionarySource = source as? [String: Any] {
            cardDictionarySource.forEach { body["source[\($0)]"] = $1 }
        }
        
        return try request.send(method: .post, path: StripeAPIEndpoint.customer(customer).endpoint, body: body.queryParameters)
    }
    
    /// Delete a customer
    /// [Learn More →](https://stripe.com/docs/api/curl#delete_customer)
    public func delete(customer: String) throws -> Future<StripeDeletedObject> {
        return try request.send(method: .delete, path: StripeAPIEndpoint.customer(customer).endpoint)
    }
    
    /// List all customers
    /// [Learn More →](https://stripe.com/docs/api/curl#list_customers)
    public func listAll(filter: [String: Any]? = nil) throws -> Future<CustomersList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }

        return try request.send(method: .get, path: StripeAPIEndpoint.customers.endpoint, query: queryParams)
    }
    
    /// Attach a source
    /// [Learn More →](https://stripe.com/docs/api/curl#attach_source)
    public func addNewSource(customer: String, source: String, toConnectedAccount: String? = nil) throws -> Future<StripeSource> {
        let body: [String: Any] = ["source": source]
        var headers: HTTPHeaders = [:]
        
        if let connectedAccount = toConnectedAccount {
            headers["Stripe-Account"] = connectedAccount
        }
        
        return try request.send(method: .post, path: StripeAPIEndpoint.customerSources(customer).endpoint, body: body.queryParameters, headers: headers)
    }
    
    /// Create a bank account
    /// [Learn More →](https://stripe.com/docs/api/curl#customer_create_bank_account)
    public func addNewBankAccountSource(customer: String, source: Any, toConnectedAccount: String? = nil, metadata: [String : String]? = nil) throws -> Future<StripeBankAccount> {
        var body: [String: Any] = [:]
        var headers: HTTPHeaders = [:]
        
        if let connectedAccount = toConnectedAccount {
            headers["Stripe-Account"] = connectedAccount
        }
        
        if let source = source as? String {
            body["source"] = source
        }
        
        if let source = source as? [String: Any] {
            source.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try request.send(method: .post, path: StripeAPIEndpoint.customerSources(customer).endpoint, body: body.queryParameters, headers: headers)
    }
    
    /// Create a card
    /// [Learn More →](https://stripe.com/docs/api/curl#create_card)
    public func addNewCardSource(customer: String, source: Any, toConnectedAccount: String? = nil, metadata: [String : String]? = nil) throws -> Future<StripeCard> {
        var body: [String: Any] = [:]
        var headers: HTTPHeaders = [:]
        
        if let connectedAccount = toConnectedAccount {
            headers["Stripe-Account"] = connectedAccount
        }
        
        if let source = source as? String {
            body["source"] = source
        }
        
        if let source = source as? [String: Any] {
            source.forEach { body["source[\($1)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try request.send(method: .post, path: StripeAPIEndpoint.customerSources(customer).endpoint, body: body.queryParameters, headers: headers)
    }

    /// Detach a source
    /// [Learn More →](https://stripe.com/docs/api/curl#detach_source)
    public func deleteSource(customer: String, source: String) throws -> Future<StripeSource> {
        return try request.send(method: .delete, path: StripeAPIEndpoint.customerDetachSources(customer, source).endpoint)
    }
}
