//
//  OrderRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Vapor

public protocol OrderRoutes {
    func create(currency: StripeCurrency, coupon: String?, customer: String?, email: String?, items: [[String: Any]]?, metadata: [String: String]?, shipping: ShippingLabel?) throws -> Future<StripeOrder>
    func retrieve(order: String) throws -> Future<StripeOrder>
    func update(order: String, coupon: String?, metadata: [String: String]?, selectedShippingMethod: String?, shipping: ShippingLabel?, status: String?) throws -> Future<StripeOrder>
    func pay(order: String, customer: String?, source: Any?, applicationFee: Int?, connectAccount: String?, email: String?, metadata: [String: String]?) throws -> Future<StripeOrder>
    func listAll(filter: [String: Any]?) throws -> Future<OrdersList>
    func `return`(order: String, items: [[String: Any]]?) throws -> Future<StripeOrder>
}

extension OrderRoutes {
    public func create(currency: StripeCurrency,
                       coupon: String? = nil,
                       customer: String? = nil,
                       email: String? = nil,
                       items: [[String: Any]]? = nil,
                       metadata: [String: String]? = nil,
                       shipping: ShippingLabel? = nil) throws -> Future<StripeOrder> {
        return try create(currency: currency,
                          coupon: coupon,
                          customer: customer,
                          email: email,
                          items: items,
                          metadata: metadata,
                          shipping: shipping)
    }
    
    public func retrieve(order: String) throws -> Future<StripeOrder> {
        return try retrieve(order: order)
    }
    
    public func update(order: String,
                       coupon: String? = nil,
                       metadata: [String: String]? = nil,
                       selectedShippingMethod: String? = nil,
                       shipping: ShippingLabel? = nil,
                       status: String? = nil) throws -> Future<StripeOrder> {
        return try update(order: order,
                          coupon: coupon,
                          metadata: metadata,
                          selectedShippingMethod: selectedShippingMethod,
                          shipping: shipping,
                          status: status)
    }
    
    public func pay(order: String,
                    customer: String? = nil,
                    source: Any? = nil,
                    applicationFee: Int? = nil,
                    connectAccount: String? = nil,
                    email: String? = nil,
                    metadata: [String: String]? = nil) throws -> Future<StripeOrder> {
        return try pay(order: order,
                       customer: customer,
                       source: source,
                       applicationFee: applicationFee,
                       connectAccount: connectAccount,
                       email: email,
                       metadata: metadata)
    }
    
    public func listAll(filter: [String : Any]? = nil) throws -> Future<OrdersList> {
        return try listAll(filter: filter)
    }
    
    public func `return`(order: String, items: [[String: Any]]? = nil) throws -> Future<StripeOrder> {
        return try `return`(order: order, items: items)
    }
}

public struct StripeOrderRoutes: OrderRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    /// Creating a new order
    /// [Learn More →](https://stripe.com/docs/api/curl#create_order)
    public func create(currency: StripeCurrency,
                       coupon: String?,
                       customer: String?,
                       email: String?,
                       items: [[String: Any]]?,
                       metadata: [String: String]?,
                       shipping: ShippingLabel?) throws -> Future<StripeOrder> {
        var body: [String: Any] = ["currency": currency.rawValue]
        
        if let coupon = coupon {
            body["coupon"] = coupon
        }
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let items = items {
            for i in 0..<items.count {
                items[i].forEach { body["items[\(i)][\($0)]"] = $1 }
            }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let shipping = shipping {
            try shipping.toEncodedDictionary().forEach { body["shipping[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.order.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve a new order
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_order)
    public func retrieve(order: String) throws -> Future<StripeOrder> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.orders(order).endpoint)
    }
    
    /// Update an order
    /// [Learn More →](https://stripe.com/docs/api/curl#update_order)
    public func update(order: String,
                       coupon: String?,
                       metadata: [String: String]?,
                       selectedShippingMethod: String?,
                       shipping: ShippingLabel?,
                       status: String?) throws -> Future<StripeOrder> {
        var body: [String: Any] = [:]
        
        if let coupon = coupon {
            body["coupon"] = coupon
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let selectedShippingMethod = selectedShippingMethod {
            body["selected_shipping_method"] = selectedShippingMethod
        }
        
        if let shipping = shipping {
            try shipping.toEncodedDictionary().forEach { body["shipping[\($0)]"] = $1 }
        }
        
        if let status = status {
            body["status"] = status
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.orders(order).endpoint, body: body.queryParameters)
    }
    
    /// Pay an order
    /// [Learn More →](https://stripe.com/docs/api/curl#pay_order)
    public func pay(order: String,
                    customer: String?,
                    source: Any?,
                    applicationFee: Int?,
                    connectAccount: String?,
                    email: String?,
                    metadata: [String: String]?) throws -> Future<StripeOrder> {
        var body: [String: Any] = [:]
        var headers: HTTPHeaders = [:]
        
        if let customer = customer {
            body["customer"] = customer
        }
        
        if let source = source as? String {
            body["source"] = source
        }
        
        if let source = source as? [String: Any] {
            source.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let applicationfee = applicationFee {
            body["application_fee"] = applicationfee
        }
        
        if let connectAccount = connectAccount {
            headers.add(name: .stripeAccount, value: connectAccount)
        }

        if let email = email {
            body["email"] = email
        }

        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        return try request.send(method: .POST, path: StripeAPIEndpoint.ordersPay(order).endpoint, body: body.queryParameters, headers: headers)
    }
    
    /// List all orders
    /// [Learn More →](https://stripe.com/docs/api/curl#list_orders)
    public func listAll(filter: [String : Any]?) throws -> Future<OrdersList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .GET, path: StripeAPIEndpoint.order.endpoint, query: queryParams)
    }

    /// Return an order
    /// [Learn More →](https://stripe.com/docs/api/curl#return_order)
    public func `return`(order: String, items: [[String: Any]]?) throws -> Future<StripeOrder> {
        var body: [String: Any] = [:]
        
        if let items = items {
            for i in 0..<items.count {
                items[i].forEach { body["items[\(i)][\($0)]"] = $1 }
            }
        }

        return try request.send(method: .POST, path: StripeAPIEndpoint.ordersReturn(order).endpoint, body: body.queryParameters)
    }
}
