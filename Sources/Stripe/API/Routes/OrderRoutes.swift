//
//  OrderRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Node
import HTTP

open class OrderRoutes {
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Creating a new order
     Creates a new order object.
     
     - parameter currency: Three-letter ISO currency code, in lowercase.
     - parameter coupon:   A coupon code that represents a discount to be applied to this order. 
                           Must be one-time duration and in same currency as the order.
     - parameter customer: The ID of an existing customer to use for this order. If provided, 
                           the customer email and shipping address will be used to create the order. 
                           Subsequently, the customer will also be charged to pay the order. If email 
                           or shipping are also provided, they will override the values retrieved from 
                           the customer object.
     - parameter email:    The email address of the customer placing the order.
     - parameter items:    List of items constituting the order.
     - parameter shipping: Shipping address for the order. Required if any of the SKUs are for products 
                           that have shippable set to true.
     - parameter metadata: A set of key/value pairs that you can attach to an order object. It can be 
                           useful for storing additional information about the order in a structured format.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func create(currency: StripeCurrency, coupon: String? = nil, customer: String? = nil, email: String? = nil, items: Node? = nil, shipping: Node? = nil, metadata: Node? = nil) throws -> StripeRequest<Order> {
        
        var body = Node([:])
        
        body["currency"] = Node(currency.rawValue)
        
        if let coupon = coupon {
            body["coupon"] = Node(coupon)
        }
        
        if let customer = customer {
            body["customer"] = Node(customer)
        }
        
        if let email = email {
            body["email"] = Node(email)
        }
        
        if let items = items?.array {
            
            for(index, item) in items.enumerated() {
                body["items[\(index)]"] = Node(item)
            }
        }
        
        if let shipping = shipping?.object {
            if let name = shipping["name"]?.string {
                body["shipping[name]"] = Node(name)
            }
            
            if let phone = shipping["phone"]?.string {
                body["shipping[phone]"] = Node(phone)
            }
            
            if let address = shipping["address"]?.object {
                if let line1 = address["line1"]?.string {
                    body["shipping[address][line1]"] = Node(line1)
                }
                
                if let city = address["city"]?.string {
                    body["shipping[address][city]"] = Node(city)
                }
                
                if let country = address["country"]?.string {
                    body["shipping[address][country]"] = Node(country)
                }
                
                if let postalCode = address["postal_code"]?.string {
                    body["shipping[address][postal_code]"] = Node(postalCode)
                }
                
                if let state = address["state"]?.string {
                    body["shipping[address][state]"] = Node(state)
                }
                
                if let line2 = address["line2"]?.string {
                    body["shipping[address][line2]"] = Node(line2)
                }
            }
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .order, query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Retrieve an order
     Retrieves the details of an existing order. Supply the unique order ID from either an order 
     creation request or the order list, and Stripe will return the corresponding order information.
     
     - parameter orderId: The ID of the order to retrieve.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func retrieve(order orderId: String) throws -> StripeRequest<Order> {
        return try StripeRequest(client: self.client, method: .get, route: .orders(orderId), query: [:], body: nil, headers: nil)
    }
    
    /**
     Update an order
     Updates the specific order by setting the values of the parameters passed. Any parameters not 
     provided will be left unchanged. This request accepts only the metadata, and status as arguments.
     
     - parameter orderId:                The ID of the order to update.
     - parameter coupon:                 A coupon code that represents a discount to be applied to this 
                                         order. Must be one-time duration and in same currency as the order.
     - parameter selectedShippingMethod: The shipping method to select for fulfilling this order. 
                                         If specified, must be one of the ids of a shipping method in the 
                                         shipping_methods array. If specified, will overwrite the existing 
                                         selected shipping method, updating items as necessary.
     - parameter shippingInformation:    Tracking information once the order has been fulfilled.
     - parameter status:                 Current order status. One of created, paid, canceled, fulfilled, 
                                         or returned.
     - parameter metadata:               A set of key/value pairs that you can attach to an order object. 
                                         It can be useful for storing additional information about the 
                                         order in a structured format.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func update(order orderId: String, coupon: String? = nil, selectedShippingMethod: String? = nil, shippingInformation: Node? = nil, status: OrderStatus? = nil, metadata: Node? = nil) throws -> StripeRequest<Order> {
        
        var body = Node([:])
        
        if let coupon = coupon {
            body["coupon"] = Node(coupon)
        }
        
        if let shippingMethod = selectedShippingMethod {
            body["selected_shipping_method"] = Node(shippingMethod)
        }
        
        if let shippingInformation = shippingInformation?.object {
            if let carrier = shippingInformation["carrier"]?.string {
                body["shipping[carrier]"] = Node(carrier)
            }
            
            if let trackingNumber = shippingInformation["tracking_number"]?.string {
                body["shipping[tracking_number]"] = Node(trackingNumber)
            }
        }
        
        if let status = status {
            body["status"] = Node(status.rawValue)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .orders(orderId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Pay an order
     Pay an order by providing a source to create a payment.
     
     - parameter orderId:        The ID of the order to pay.
     - parameter customer:       The ID of an existing customer that will be charged in this request.
     - parameter source:         A payment source to be charged, such as a credit card. If you also pass a 
                                 customer ID, the source must be the ID of a source belonging to the customer 
                                 (e.g., a saved card). Otherwise, if you do not pass a customer ID, the source 
                                 you provide must either be a token, like the ones returned by Stripe.js, or a 
                                 dictionary containing a user's credit card details, with the options described 
                                 below. Although not all information is required, the extra info helps prevent fraud.
     - parameter applicationFee: A fee in cents that will be applied to the order and transferred to the 
                                 application owner's Stripe account. To use an application fee, the request 
                                 must be made on behalf of another account, using the Stripe-Account header 
                                 or OAuth key. For more information, see the application fees documentation.
     - parameter email:          The email address of the customer placing the order. If a customer is specified, 
                                 that customer's email address will be used.
     - parameter metadata:       A set of key/value pairs that you can attach to an order object. It can be useful 
                                 for storing additional information about the order in a structured format.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func pay(order orderId: String, customer: String? = nil, source: Node? = nil, applicationFee: Int? = nil, email: String? = nil, metadata: Node? = nil) throws -> StripeRequest<Order> {
        var body = Node([:])
        
        if let customer = customer {
            body["customer"] = Node(customer)
        }
        
        if let source = source?.object {
            
            if let exp = source["exp_month"]?.int {
                body["source[exp_month]"] = Node(exp)
            }
            
            if let expYear = source["exp_year"]?.int {
                body["source[exp_year]"] = Node(expYear)
            }
            
            if let number = source["number"]?.string {
                body["source[number]"] = Node(number)
            }
            
            if let object = source["object"]?.string {
                body["source[object]"] = Node(object)
            }
            
            if let cvc = source["cvc"]?.int {
                body["source[cvc]"] = Node(cvc)
            }
            
            if let city = source["address_city"]?.string {
                body["source[address_city]"] = Node(city)
            }
            
            if let country = source["address_country"]?.string {
                body["source[address_country]"] = Node(country)
            }
            
            if let line1 = source["address_line1"]?.string {
                body["source[address_line1]"] = Node(line1)
            }
            
            if let line2 = source["address_line2"]?.string {
                body["source[address_line2]"] = Node(line2)
            }
            
            if let name = source["name"]?.string {
                body["source[name]"] = Node(name)
            }
            
            if let state = source["address_state"]?.string {
                body["source[address_state]"] = Node(state)
            }
            
            if let zip = source["address_zip"]?.string {
                body["source[address_zip]"] = Node(zip)
            }
        }
        
        if let source = source?.string {
            body["source"] = Node(source)
        }
        
        if let appFee = applicationFee {
            body["application_fee"] = Node(appFee)
        }
        
        if let email = email {
            body["email"] = Node(email)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .ordersPay(orderId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     List all orders
     Returns a list of your orders. The orders are returned sorted by creation date, with the most 
     recently created orders appearing first.
     
     - parameter filter: A Filter item to pass query parameters when fetching results
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func listAll(filter: StripeFilter? = nil) throws -> StripeRequest<OrderList> {
        var query = [String : NodeRepresentable]()
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .order, query: query, body: nil, headers: nil)
    }
    
    /**
     Return an order
     Return all or part of an order. The order must have a status of paid or fulfilled before it can 
     be returned. Once all items have been returned, the order will become canceled or returned depending 
     on which status the order started in.
     
     - parameter orderId: The ID of the order to return
     - parameter items:   List of items to return.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func `return`(order orderId: String, items: Node? = nil) throws -> StripeRequest<OrderReturn> {
        
        var body = Node([:])
        
        if let items = items?.array {
            
            for(index, item) in items.enumerated() {
                body["items[\(index)]"] = Node(item)
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .ordersReturn(orderId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
}
