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
     
     - parameter accountBalance: An integer amount in cents that is the starting account balance for your customer. 
                                 A negative amount represents a credit that will be used before attempting any charges 
                                 to the customer’s card; a positive amount will be added to the next invoice.
     
     - parameter businessVATId: The customer’s VAT identification number.
     
     - parameter coupon:  If you provide a coupon code, the customer will have a discount applied on all recurring charges.
     
     - parameter defaultSource: Either a card 
     
     - parameter description: An arbitrary string that you can attach to a customer object. It is displayed
     alongside the customer in the dashboard. This will be unset if you POST an
     empty value.
     
     - parameter email:       The Customer’s email address. It’s displayed alongside the customer in your
                              dashboard and can be useful for searching and tracking.
     
     - parameter metadata:    A set of key/value pairs that you can attach to a customer object. It can be 
                              useful for storing additional information about the customer in a structured 
                              format. You can unset individual keys if you POST an empty value for that key. 
                              You can clear all keys if you POST an empty value for metadata.
     
     - parameter shippingLabel: Shipping label.
     
     - parameter source: A one time token ID created from a source.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    public func create(accountBalance: Int?, businessVATId: String?, coupon: String?, defaultSource: String?, description: String?, email: String?, metadata: Node?, shipping: ShippingLabel?, source: String?) throws -> StripeRequest<Customer> {
        var body = Node([:])
        
        if let accountBalance = accountBalance {
            body["account_balance"] = Node(accountBalance)
        }
        
        if let businessVATId = businessVATId {
            body["business_vat_id"] = Node(businessVATId)
        }
        
        if let coupon = coupon {
            body["coupon"] = Node(coupon)
        }
        
        if let defaultSource = defaultSource {
            body["default_source"] = Node(defaultSource)
        }
        
        if let description = description {
            body["description"] = Node(description)
        }
        
        if let email = email {
            body["email"] = Node(email)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        if let shippingLabel = shipping {
            if let name = shippingLabel.name {
                body["shipping[name]"] = Node(name)
            }
            
            if let carrier = shippingLabel.carrier {
                body["shipping[carrier]"] = Node(carrier)
            }
            
            if let phone = shippingLabel.phone {
                body["shipping[phone]"] = Node(phone)
            }
            
            if let trackingNumber = shippingLabel.trackingNumber {
                body["shipping[tracking_number]"] = Node(trackingNumber)
            }
            
            if let address = shippingLabel.address {
                if let line1 = address.addressLine1 {
                    body["shipping[address][line1]"] = Node(line1)
                }
                
                if let city = address.city {
                    body["shipping[address][city]"] = Node(city)
                }
                
                if let country = address.country {
                    body["shipping[address][country]"] = Node(country)
                }
                
                if let postalCode = address.postalCode {
                    body["shipping[address][postal_code]"] = Node(postalCode)
                }
                
                if let state = address.state {
                    body["shipping[address][state]"] = Node(state)
                }
                
                if let line2 = address.addressLine2 {
                    body["shipping[address][line2]"] = Node(line2)
                }
            }
        }
        
        if let source = source {
            body["source"] = Node(source)
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .customers, query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
        
    /**
     Adds a new source for the customer. Either a bank account token or a card token.
     
     - parameter customerId: The customer object to add the source to
     - parameter account:    A connect account to add the customer to
     - parameter source:     The source token to add to the customer (Bank account or Card).
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func addNewSource(for customerId: String, inConnectAccount account: String?, source: String) throws -> StripeRequest<Card> {
        let body = try Node(node: ["source": source])
        
        var headers: [HeaderKey: String]?
        
        // Check if we have an account to set it to
        if let account = account {
            headers = [StripeHeader.Account : account]
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .customerSources(customerId), query: [:], body: Body.data(body.formURLEncoded()), headers: headers)
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
     
     - parameter accountBalance:    An integer amount in cents that is the starting account balance for your customer.
                                    A negative amount represents a credit that will be used before attempting any charges
                                    to the customer’s card; a positive amount will be added to the next invoice.
     
     - parameter businessVATId:     The customer’s VAT identification number.
     
     - parameter coupon:            If you provide a coupon code, the customer will have a discount applied on all recurring charges.
     
     - parameter defaultSourceId:   Either a card
     
     - parameter description:       An arbitrary string that you can attach to a customer object. It is displayed
                                    alongside the customer in the dashboard. This will be unset if you POST an
                                    empty value.
     
     - parameter email:             The Customer’s email address. It’s displayed alongside the customer in your
                                    dashboard and can be useful for searching and tracking.
     
     - parameter metadata:          A set of key/value pairs that you can attach to a customer object. It can be
                                    useful for storing additional information about the customer in a structured
                                    format. You can unset individual keys if you POST an empty value for that key.
                                    You can clear all keys if you POST an empty value for metadata.
     
     - parameter shippingLabel:     Shipping label.
     
     - parameter newSource:         A one time token ID created from a source.
     
     - parameter customerId:        A customer class created with appropiate values set. Any unset parameters (nil)
                                    will unset the value on stripe
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func update(accountBalance: Int?, businessVATId: String?, coupon: String?, defaultSourceId: String?, description:String?, email: String?, metadata: Node?, shipping:ShippingLabel?, newSource: String?, forCustomerId customerId: String) throws -> StripeRequest<Customer> {
        var body = Node([:])
        
        if let accountBalance = accountBalance {
            body["account_balance"] = Node(accountBalance)
        }
        
        if let businessVATId = businessVATId {
            body["business_vat_id"] = Node(businessVATId)
        }
        
        if let coupon = coupon {
            body["coupon"] = Node(coupon)
        }
        
        if let defaultSourceId = defaultSourceId {
            body["default_source"] = Node(defaultSourceId)
        }
        
        if let description = description {
            body["description"] = Node(description)
        }
        
        if let email = email {
            body["email"] = Node(email)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }

        if let shippingLabel = shipping {
            if let name = shippingLabel.name {
                body["shipping[name]"] = Node(name)
            }
            
            if let carrier = shippingLabel.carrier {
                body["shipping[carrier]"] = Node(carrier)
            }
            
            if let phone = shippingLabel.phone {
                body["shipping[phone]"] = Node(phone)
            }
            
            if let trackingNumber = shippingLabel.trackingNumber {
                body["shipping[tracking_number]"] = Node(trackingNumber)
            }
            
            if let address = shippingLabel.address {
                if let line1 = address.addressLine1 {
                    body["shipping[address][line1]"] = Node(line1)
                }
                
                if let city = address.city {
                    body["shipping[address][city]"] = Node(city)
                }
                
                if let country = address.country {
                    body["shipping[address][country]"] = Node(country)
                }
                
                if let postalCode = address.postalCode {
                    body["shipping[address][postal_code]"] = Node(postalCode)
                }
                
                if let state = address.state {
                    body["shipping[address][state]"] = Node(state)
                }
                
                if let line2 = address.addressLine2 {
                    body["shipping[address][line2]"] = Node(line2)
                }
            }
        }
        
        if let newSource = newSource {
            body["source"] = Node(newSource)
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
    public func listAll(filter: StripeFilter?) throws -> StripeRequest<CustomerList> {
        var query = [String : NodeRepresentable]()
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .customers, query: query, body: nil, headers: nil)
    }
}
