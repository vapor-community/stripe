//
//  InvoiceRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/4/17.
//
//

import Vapor
import Foundation

public protocol InvoiceRoutes {    
    func create(customer: String, applicationFee: Int?, connectAccount: String?, billing: String?, daysUntilDue: Int?, description: String?, dueDate: Date?, metadata: [String: String]?, statementDescriptor: String?, subscription: String?, taxPercent: Decimal?) throws -> Future<StripeInvoice>
    func retrieve(invoice: String) throws -> Future<StripeInvoice>
    func retrieveLineItems(invoice: String, filter: [String: Any]?) throws -> Future<InvoiceLineGroup>
    func retrieveUpcomingInvoice(customer: String, filter: [String: Any]?) throws -> Future<StripeInvoice>
    func update(invoice: String, applicationFee: Int?, connectAccount: String?, closed: Bool?, description: String?, forgiven: Bool?, metadata: [String: String]?, paid: Bool?, statementDescriptor: String?, taxPercent: Decimal?) throws -> Future<StripeInvoice>
    func pay(invoice: String, source: String?) throws -> Future<StripeInvoice>
    func listAll(filter: [String: Any]?) throws -> Future<InvoiceLineGroup>
}

extension InvoiceRoutes {
    public func create(customer: String,
                       applicationFee: Int? = nil,
                       connectAccount: String? = nil,
                       billing: String? = nil,
                       daysUntilDue: Int? = nil,
                       description: String? = nil,
                       dueDate: Date? = nil,
                       metadata: [String : String]? = nil,
                       statementDescriptor: String? = nil,
                       subscription: String? = nil,
                       taxPercent: Decimal? = nil) throws -> Future<StripeInvoice> {
        return try create(customer: customer,
                          applicationFee: applicationFee,
                          connectAccount: connectAccount,
                          billing: billing,
                          daysUntilDue: daysUntilDue,
                          description: description,
                          dueDate: dueDate,
                          metadata: metadata,
                          statementDescriptor: statementDescriptor,
                          subscription: subscription,
                          taxPercent: taxPercent)
    }
    
    public func retrieve(invoice: String) throws -> Future<StripeInvoice> {
        return try retrieve(invoice: invoice)
    }
    
    public func retrieveLineItems(invoice: String, filter: [String: Any]? = nil) throws -> Future<InvoiceLineGroup> {
        return try retrieveLineItems(invoice: invoice, filter: filter)
    }
    
    public func retrieveUpcomingInvoice(customer: String, filter: [String: Any]? = nil) throws -> Future<StripeInvoice> {
        return try retrieveUpcomingInvoice(customer: customer, filter: filter)
    }
    
    public func update(invoice: String,
                       applicationFee: Int? = nil,
                       connectAccount: String? = nil,
                       closed: Bool? = nil,
                       description: String? = nil,
                       forgiven: Bool? = nil,
                       metadata: [String : String]? = nil,
                       paid: Bool? = nil,
                       statementDescriptor: String? = nil,
                       taxPercent: Decimal? = nil) throws -> Future<StripeInvoice> {
        return try update(invoice: invoice,
                          applicationFee: applicationFee,
                          connectAccount: connectAccount,
                          closed: closed,
                          description: description,
                          forgiven: forgiven,
                          metadata: metadata,
                          paid: paid,
                          statementDescriptor: statementDescriptor,
                          taxPercent: taxPercent)
    }
    
    public func pay(invoice: String, source: String? = nil) throws -> Future<StripeInvoice> {
        return try pay(invoice: invoice, source: source)
    }
    
    public func listAll(filter: [String : Any]? = nil) throws -> Future<InvoiceLineGroup> {
        return try listAll(filter: filter)
    }
}

public struct StripeInvoiceRoutes: InvoiceRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    /// Create an invoice
    /// [Learn More →](https://stripe.com/docs/api/curl#create_invoice)
    public func create(customer: String,
                       applicationFee: Int?,
                       connectAccount: String?,
                       billing: String?,
                       daysUntilDue: Int?,
                       description: String?,
                       dueDate: Date?,
                       metadata: [String : String]?,
                       statementDescriptor: String?,
                       subscription: String?,
                       taxPercent: Decimal?) throws -> Future<StripeInvoice> {
        var body: [String: Any] = [:]
        var headers: HTTPHeaders = [:]
        
        body["customer"] = customer
        
        if let applicationFee = applicationFee {
            body["application_fee_amount"] = applicationFee
        }
        
        if let connectAccount = connectAccount {
            headers.add(name: .stripeAccount, value: connectAccount)
        }
        
        if let billing = billing {
            body["billing"] = billing
        }
        
        if let daysUntilDue = daysUntilDue {
            body["days_until_due"] = daysUntilDue
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let dueDate = dueDate {
            body["due_date"] = Int(dueDate.timeIntervalSince1970)
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let subscription = subscription {
            body["subscription"] = subscription
        }
        
        if let taxPercent = taxPercent {
            body["tax_percent"] = taxPercent
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.invoices.endpoint, body: body.queryParameters, headers: headers)
    }
    
    /// Retrieve an invoice
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_invoice)
    public func retrieve(invoice: String) throws -> Future<StripeInvoice> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.invoice(invoice).endpoint)
    }
    
    /// Retrieve an invoice's line items
    /// [Learn More →](https://stripe.com/docs/api/curl#invoice_lines)
    public func retrieveLineItems(invoice: String, filter: [String: Any]?) throws -> Future<InvoiceLineGroup> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.invoiceLines(invoice).endpoint, query: filter?.queryParameters ?? "")
    }
    
    /// Retrieve an upcoming invoice
    /// [Learn More →](https://stripe.com/docs/api/curl#upcoming_invoice)
    public func retrieveUpcomingInvoice(customer: String, filter: [String: Any]?) throws -> Future<StripeInvoice> {
        var query: [String: Any] = ["customer": customer]
        
        if let filter = filter {
            filter.forEach { query["\($0)"] = $1 }
        }
        
        return try request.send(method: .GET, path: StripeAPIEndpoint.upcomingInvoices.endpoint, query: query.queryParameters)
    }
    
    /// Update an invoice
    /// [Learn More →](https://stripe.com/docs/api/curl#update_invoice)
    public func update(invoice: String,
                       applicationFee: Int?,
                       connectAccount: String?,
                       closed: Bool?,
                       description: String?,
                       forgiven: Bool?,
                       metadata: [String : String]?,
                       paid: Bool?,
                       statementDescriptor: String?,
                       taxPercent: Decimal?) throws -> Future<StripeInvoice> {
        var body: [String: Any] = [:]
        var headers: HTTPHeaders = [:]
        
        if let applicationFee = applicationFee {
            body["application_fee_amount"] = applicationFee
        }
        
        if let connectAccount = connectAccount {
            headers.add(name: .stripeAccount, value: connectAccount)
        }
        
        if let closed = closed {
            body["closed"] = closed
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let forgiven = forgiven {
            body["forgiven"] = forgiven
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let paid = paid {
            body["paid"] = paid
        }

        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let taxPercent = taxPercent {
            body["tax_percent"] = taxPercent
        }

        return try request.send(method: .POST, path: StripeAPIEndpoint.invoice(invoice).endpoint, body: body.queryParameters, headers: headers)
    }
    
    /// Pay an invoice
    /// [Learn More →](https://stripe.com/docs/api/curl#pay_invoice)
    public func pay(invoice: String, source: String?) throws -> Future<StripeInvoice> {
        var body: [String: Any] = [:]

        if let source = source {
            body["source"] = source
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.payInvoice(invoice).endpoint, body: body.queryParameters)
    }
    
    /// List all invoices
    /// [Learn More →](https://stripe.com/docs/api/curl#list_invoices)
    public func listAll(filter: [String : Any]?) throws -> Future<InvoiceLineGroup> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .GET, path: StripeAPIEndpoint.invoices.endpoint, query: queryParams)
    }
}
