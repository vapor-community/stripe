//
//  InvoiceItemRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/5/17.
//
//

import Node
import HTTP

public final class InvoiceItemRoutes {
    
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Create an invoice item
     Adds an arbitrary charge or credit to the customer’s upcoming invoice.
     
     - parameter customer:     The ID of the customer who will be billed when this invoice item is billed.
     - parameter amount:       The integer amount in cents of the charge to be applied to the upcoming invoice. 
                               To apply a credit to the customer’s account, pass a negative amount.
     - parameter currency:     Three-letter ISO currency code, in lowercase. Must be a supported currency.
     - parameter invoice:      The ID of an existing invoice to add this invoice item to. When left blank, the 
                               invoice item will be added to the next upcoming scheduled invoice. Use this when adding 
                               invoice items in response to an invoice.created webhook. You cannot add an invoice item 
                               to an invoice that has already been paid, attempted or closed.
     - parameter subscription: The ID of a subscription to add this invoice item to. When left blank, the invoice item 
                               will be be added to the next upcoming scheduled invoice. When set, scheduled invoices for 
                               subscriptions other than the specified subscription will ignore the invoice item. Use this 
                               when you want to express that an invoice item has been accrued within the context of a 
                               particular subscription.
     - parameter description:  An arbitrary string which you can attach to the invoice item. The description is displayed 
                               in the invoice for easy tracking. This will be unset if you POST an empty value.
     - parameter discountable: Controls whether discounts apply to this invoice item. Defaults to false for prorations or 
                               negative invoice items, and true for all other invoice items.
     - parameter metadata:     A set of key/value pairs that you can attach to an invoice item object. It can be useful for 
                               storing additional information about the invoice item in a structured format. You can unset 
                               individual keys if you POST an empty value for that key. You can clear all keys if you POST 
                               an empty value for metadata.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    public func createItem(forCustomer customer: String, amount: Int, inCurrency currency: StripeCurrency, toInvoice invoice: String? = nil, toSubscription subscription: String? = nil, description: String? = nil, discountable: Bool? = nil, metadata: Node? = nil) throws -> StripeRequest<InvoiceItem> {
        var body = Node([:])
        
        body["customer"] = Node(customer)
        body["amount"] = Node(amount)
        body["currency"] = Node(currency.rawValue)
        
        if let subscription = subscription {
            body["subscription"] = Node(subscription)
        }
        
        if let invoice = invoice {
            body["invoice"] = Node(invoice)
        }
        
        if let description = description {
            body["description"] = Node(description)
        }
        
        if let discountable = discountable {
            body["discountable"] = Node(discountable)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .invoiceItems, body: Body.data(body.formURLEncoded()), headers: nil)
    }

    /**
     Fetch an invoice
     Retrieves the invoice with the given ID.
     
     - parameter invoice: The ID of the desired invoice item.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func fetch(invoiceItem invoiceItemId: String) throws -> StripeRequest<InvoiceItem> {
        return try StripeRequest(client: self.client, method: .post, route: .invoiceItem(invoiceItemId), body: nil, headers: nil)
    }
    
    /**
     Update an invoice item
     Updates the amount or description of an invoice item on an upcoming invoice. Updating an invoice item 
     is only possible before the invoice it’s attached to is closed.
     
     - parameter amount:       The integer amount in cents of the charge to be applied to the upcoming invoice. 
                               To apply a credit to the customer’s account, pass a negative amount.
     - parameter description:  An arbitrary string which you can attach to the invoice item. The description is displayed 
                               in the invoice for easy tracking. This will be unset if you POST an empty value.
     - parameter discountable: Controls whether discounts apply to this invoice item. Defaults to false for prorations or 
                               negative invoice items, and true for all other invoice items.
     - parameter metadata:     A set of key/value pairs that you can attach to an invoice item object. It can be useful for 
                               storing additional information about the invoice item in a structured format. You can unset 
                               individual keys if you POST an empty value for that key. You can clear all keys if you POST 
                               an empty value for metadata.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    public func update(invoiceItem invoiceItemId: String, amount: Int, description: String? = nil, discountable: Bool? = nil, metadata: Node? = nil) throws -> StripeRequest<InvoiceItem> {
        var body = Node([:])
        
        body["amount"] = Node(amount)
        
        if let description = description {
            body["description"] = Node(description)
        }
        
        if let discountable = discountable {
            body["discountable"] = Node(discountable)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .invoiceItem(invoiceItemId), body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Delete an invoice item
     Removes an invoice item from the upcoming invoice. Removing an invoice item is only possible before the 
     invoice it’s attached to is closed.
     
     - parameter invoice: The ID of the desired invoice item.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func delete(invoiceItem invoiceItemId: String) throws -> StripeRequest<DeletedObject> {
        return try StripeRequest(client: self.client, method: .delete, route: .invoiceItem(invoiceItemId), body: nil, headers: nil)
    }
    
    /**
     List all invoice items
     Returns a list of your invoice items. Invoice items are returned sorted by creation date, with the most 
     recently created invoice items appearing first.
     
     - parameter filter: A Filter item to pass query parameters when fetching results
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func listAll(customer: String? = nil, filter: StripeFilter? = nil) throws -> StripeRequest<InvoiceItemList> {
        var query = [String : NodeRepresentable]()
        if let customer = customer {
            query["customer"] = customer
        }
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .invoiceItems, query: query, body: nil, headers: nil)
    }
}
