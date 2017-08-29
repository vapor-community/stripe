//
//  OrderRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation
import Node


import HTTP

public final class OrderRoutes {
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    public func create(currency: StripeCurrency, coupon: String?, customer: String?, email: String?, items: Node?, shipping: Node?, metadata: Node? = nil) throws -> StripeRequest<Order> {
        
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
    
    public func retrieve(order orderId: String) throws -> StripeRequest<Order> {
        return try StripeRequest(client: self.client, method: .get, route: .orders(orderId), query: [:], body: nil, headers: nil)
    }
    
    public func update(order orderId: String, coupon: String?, selectedShippingMethod: String?, shippingInformation: Node?, status: OrderStatus?, metadata: Node? = nil) throws -> StripeRequest<Order> {
        
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
    
    public func pay(order orderId: String, customer: String?, source: Node?, applicationFee: Int?, email: String?, metadata: Node? = nil) throws -> StripeRequest<Order> {
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
    
    public func listAll(filter: StripeFilter? = nil) throws -> StripeRequest<OrderList> {
        var query = [String : NodeRepresentable]()
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .order, query: query, body: nil, headers: nil)
    }
    
    public func `return`(order orderId: String, items: Node?) throws -> StripeRequest<OrderReturn> {
        
        var body = Node([:])
        
        if let items = items?.array {
            
            for(index, item) in items.enumerated() {
                body["items[\(index)]"] = Node(item)
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .ordersReturn(orderId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
}
