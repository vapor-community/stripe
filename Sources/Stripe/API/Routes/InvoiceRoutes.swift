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
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
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
            body["tax_percent"] = Node(taxPercent)
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = Node(statementDescriptor)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .invoices, body: Body.data(body.formURLEncoded()), headers: headers)
    }
    
    /**
     Retrieves the invoice with the given ID.
     
     - parameter invoice: The Invoice ID to fetch
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    public func fetch(invoice invoiceId: String) throws -> StripeRequest<Invoice> {
        return try StripeRequest(client: self.client, method: .post, route: .invoice(invoiceId), body: nil, headers: nil)
    }
    
    /**
     When retrieving an invoice, you’ll get a lines property containing the total count of line items and the first handful 
     of those items. There is also a URL where you can retrieve the full (paginated) list of line items.
     
     - parameter invoiceId: The Invoice ID to fetch
     - parameter customer:  In the case of upcoming invoices, the customer of the upcoming invoice is required. In other 
                            cases it is ignored.
     - parameter coupon:    For upcoming invoices, preview applying this coupon to the invoice. If a subscription or 
                            subscription_items is provided, the invoice returned will preview updating or creating a 
                            subscription with that coupon. Otherwise, it will preview applying that coupon to the customer 
                            for the next upcoming invoice from among the customer’s subscriptions. Otherwise this parameter 
                            is ignored. This will be unset if you POST an empty value.
     - parameter filter:    Parameters used to filter the results
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    
    public func listItems(forInvoice invoiceId: String, customer: String? = nil, coupon: String? = nil, filter: StripeFilter? = nil) throws -> StripeRequest<InvoiceLineGroup> {
        var query = [String : NodeRepresentable]()
        if let data = try filter?.createQuery() {
            query = data
        }
        
        if let customer = customer {
            query["customer"] = customer
        }
        
        if let coupon = coupon {
            query["coupon"] = coupon
        }
        
        return try StripeRequest(client: self.client, method: .get, route: .invoiceLines(invoiceId), query: query, body: nil, headers: nil)
    }
    
    /**
     At any time, you can preview the upcoming invoice for a customer. This will show you all the charges that are pending, 
     including subscription renewal charges, invoice item charges, etc. It will also show you any discount that is applicable 
     to the customer.
     
     - parameter customerId:    The identifier of the customer whose upcoming invoice you’d like to retrieve.
     - parameter coupon:        The code of the coupon to apply. If subscription or subscription_items is provided, the invoice 
                                returned will preview updating or creating a subscription with that coupon. Otherwise, it will 
                                preview applying that coupon to the customer for the next upcoming invoice from among the customer’s 
                                subscriptions. The invoice can be previewed without a coupon by passing this value as an empty string.
     - parameter subscription:  The identifier of the subscription for which you’d like to retrieve the upcoming invoice. If not provided, 
                                but a subscription_items is provided, you will preview creating a subscription with those items. If neither 
                                subscription nor subscription_items is provided, you will retrieve the next upcoming invoice from among the 
                                customer’s subscriptions.
     - parameter filter:        Parameters used to filter the result
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    public func upcomingInvoice(forCustomer customerId: String, coupon: String? = nil, subscription: String? = nil, filter: StripeFilter? = nil) throws -> StripeRequest<Invoice> {
        var query = [String : NodeRepresentable]()
        query["customer"] = customerId
        
        if let data = try filter?.createQuery() {
            query = data
        }
        
        if let coupon = coupon {
            query["coupon"] = coupon
        }
        
        if let subscription = subscription {
            query["subscription"] = subscription
        }
        
        return try StripeRequest(client: self.client, method: .get, route: .upcomingInvoices, query: query, body: nil, headers: nil)
    }
    
    /**
     Until an invoice is paid, it is marked as open (closed=false). If you’d like to stop Stripe from attempting to collect payment on an 
     invoice or would simply like to close the invoice out as no longer owed by the customer, you can update the closed parameter.
     
     - parameter invoiceId:           The ID of the Invoice to update
     - parameter closed:              Boolean representing whether an invoice is closed or not. To close an invoice, pass true.
     - parameter forgiven:            Boolean representing whether an invoice is forgiven or not. To forgive an invoice, pass true. 
                                      Forgiving an invoice instructs us to update the subscription status as if the invoice were successfully paid. 
                                      Once an invoice has been forgiven, it cannot be unforgiven or reopened.
     - parameter applicationFee:      A fee in cents that will be applied to the invoice and transferred to the application owner’s Stripe account. 
                                      The request must be made with an OAuth key or the Stripe-Account header in order to take an application fee. 
                                      For more information, see the application fees documentation.
     - parameter account:             The account to transfer the fee to
     - parameter description:         A description for the invoice
     - parameter metadata:            Aditional metadata info
     - parameter taxPercent:          The percent tax rate applied to the invoice, represented as a decimal number. The tax rate of an attempted, 
                                      paid or forgiven invoice cannot be changed.
     - parameter statementDescriptor: Extra information about a charge for the customer’s credit card statement.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    public func update(invoice invoiceId: String, closed: Bool? = nil, forgiven: Bool? = nil, applicationFee: Int? = nil, toAccount account: String? = nil, description: String? = nil, metadata: Node? = nil, taxPercent: Double? = nil, statementDescriptor: String? = nil) throws -> StripeRequest<Invoice> {
        var body = Node([:])
        // Create the headers
        var headers: [HeaderKey : String]?
        if let account = account {
            headers = [
                StripeHeader.Account: account
            ]
            
            if let fee = applicationFee {
                body["application_fee"] = Node(fee)
            }
        }
        
        if let closed = closed {
            body["closed"] = Node(closed)
        }
        
        if let forgiven = forgiven {
            body["forgiven"] = Node(forgiven)
        }
        
        if let description = description {
            body["description"] = Node(description)
        }
        
        if let taxPercent = taxPercent {
            body["tax_percent"] = Node(taxPercent)
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = Node(statementDescriptor)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .invoice(invoiceId), body: Body.data(body.formURLEncoded()), headers: headers)
    }
}
