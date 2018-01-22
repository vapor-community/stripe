//
//  InvoiceItemRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/5/17.
//
//

import Vapor

public protocol InvoiceItemRoutes {
    associatedtype II: InvoiceItem
    associatedtype DO: DeletedObject
    associatedtype L: List
    
    func create(amount: Int, currency: StripeCurrency, customer: String, description: String?, discountable: Bool?, invoice: String?, metadata: [String: String]?, subscription: String?) throws -> Future<II>
    func retrieve(invoiceItem: String) throws -> Future<II>
    func update(invoiceItem: String, amount: Int?, description: String?, discountable: Bool?, metadata: [String: String]?) throws -> Future<II>
    func delete(invoiceItem: String) throws -> Future<DO>
    func listAll(filter: [String: Any]?) throws -> Future<L>
}

public struct StripeInvoiceItemRoutes<SR: StripeRequest>: InvoiceItemRoutes {
    private let request: SR
    
    init(request: SR) {
        self.request = request
    }
    
    /// Create an invoice item
    /// [Learn More →](https://stripe.com/docs/api/curl#create_invoiceitem)
    public func create(amount: Int,
                       currency: StripeCurrency,
                       customer: String,
                       description: String? = nil,
                       discountable: Bool? = nil,
                       invoice: String? = nil,
                       metadata: [String : String]? = nil,
                       subscription: String? = nil) throws -> Future<StripeInvoiceItem> {
        var body: [String: Any] = [:]
        
        body["amount"] = amount
        body["currency"] = currency.rawValue
        body["customer"] = customer
        
        if let description = description {
            body["description"] = description
        }
        
        if let discountable = discountable {
            body["discountable"] = discountable
        }
        
        if let invoice = invoice {
            body["invoice"] = invoice
        }
        
        if let metadata = metadata {
            metadata.forEach { key,value in
                body["metadata[\(key)]"] = value
            }
        }
        
        if let subscription = subscription {
            body["subscription"] = subscription
        }
        
        return try request.send(method: .post, path: StripeAPIEndpoint.invoiceItems.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve an invoice item
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_invoiceitem)
    public func retrieve(invoiceItem: String) throws -> Future<StripeInvoiceItem> {
        return try request.send(method: .get, path: StripeAPIEndpoint.invoiceItem(invoiceItem).endpoint)
    }
    
    /// Update an invoice item
    /// [Learn More →](https://stripe.com/docs/api/curl#update_invoiceitem)
    public func update(invoiceItem: String,
                       amount: Int? = nil,
                       description: String? = nil,
                       discountable: Bool? = nil,
                       metadata: [String : String]? = nil) throws -> Future<StripeInvoiceItem> {
        var body: [String: Any] = [:]
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let discountable = discountable {
            body["discountable"] = discountable
        }

        if let metadata = metadata {
            metadata.forEach { key,value in
                body["metadata[\(key)]"] = value
            }
        }
        
        return try request.send(method: .post, path: StripeAPIEndpoint.invoiceItem(invoiceItem).endpoint, body: body.queryParameters)
    }
    
    /// Delete an invoice item
    /// [Learn More →](https://stripe.com/docs/api/curl#delete_invoiceitem)
    public func delete(invoiceItem: String) throws -> Future<StripeDeletedObject> {
        return try request.send(method: .delete, path: StripeAPIEndpoint.invoiceItem(invoiceItem).endpoint)
    }
    
    /// List all invoice items
    /// [Learn More →](https://stripe.com/docs/api/curl#list_invoiceitems)
    public func listAll(filter: [String: Any]? = nil) throws -> Future<InvoiceItemsList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .get, path: StripeAPIEndpoint.invoiceItems.endpoint, query: queryParams)
    }
}
