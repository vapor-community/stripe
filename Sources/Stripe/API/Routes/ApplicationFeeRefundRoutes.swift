//
//  ApplicationFeeRefundRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/17/19.
//

import Vapor

public protocol ApplicationFeeRefundRoutes {
    /// Refunds an application fee that has previously been collected but not yet refunded. Funds will be refunded to the Stripe account from which the fee was originally collected.
    /// You can optionally refund only part of an application fee. You can do so multiple times, until the entire fee has been refunded.
    /// Once entirely refunded, an application fee can’t be refunded again. This method will return an error when called on an already-refunded application fee, or when trying to refund more money than is left on an application fee.
    ///
    /// - Parameters:
    ///   - fee: The identifier of the application fee to be refunded.
    ///   - amount: A positive integer, in `cents`, representing how much of this fee to refund. Can refund only up to the remaining unrefunded amount of the fee.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    /// - Returns: A `StripeApplicationFeeRefund`.
    /// - Throws: A `StripeError`.
    func create(fee: String, amount: Int?, metadata: [String: String]?) throws -> EventLoopFuture<StripeApplicationFeeRefund>
    
    
    /// By default, you can see the 10 most recent refunds stored directly on the application fee object, but you can also retrieve details about a specific refund stored on the application fee.
    ///
    /// - Parameters:
    ///   - refund: ID of refund to retrieve.
    ///   - fee: ID of the application fee refunded.
    /// - Returns: A `StripeApplicationFeeRefund`.
    /// - Throws: A `StripeError`.
    func retrieve(refund: String, fee: String) throws -> EventLoopFuture<StripeApplicationFeeRefund>
    
    
    /// Updates the specified application fee refund by setting the values of the parameters passed. Any parameters not provided will be left unchanged.
    /// This request only accepts metadata as an argument.
    ///
    /// - Parameters:
    ///   - refund: ID of refund to retrieve.
    ///   - fee: ID of the application fee refunded.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to `metadata`.
    /// - Returns: A `StripeApplicationFeeRefund`.
    /// - Throws: A `StripeError`.
    func update(refund: String, fee: String, metadata: [String: String]?) throws -> EventLoopFuture<StripeApplicationFeeRefund>
    
    
    /// You can see a list of the refunds belonging to a specific application fee. Note that the 10 most recent refunds are always available by default on the application fee object. If you need more than those 10, you can use this API method and the limit and starting_after parameters to page through additional refunds.
    ///
    /// - Parameters:
    ///   - fee: The ID of the application fee whose refunds will be retrieved.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/fee_refunds/list)
    /// - Returns: A `StripeApplicationFeeRefundList`.
    /// - Throws: A `StripeError`.
    func listAll(fee: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeApplicationFeeRefundList>
}

extension ApplicationFeeRefundRoutes {
    public func create(fee: String, amount: Int? = nil, metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeApplicationFeeRefund> {
        return try create(fee: fee, amount: amount, metadata: metadata)
    }
    
    public func retrieve(refund: String, fee: String) throws -> EventLoopFuture<StripeApplicationFeeRefund> {
        return try retrieve(refund: refund, fee: fee)
    }
    
    public func update(refund: String, fee: String, metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeApplicationFeeRefund> {
        return try update(refund: refund, fee: fee, metadata: metadata)
    }
    
    public func listAll(fee: String, filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeApplicationFeeRefundList> {
        return try listAll(fee: fee, filter: filter)
    }
}

public struct StripeApplicationFeeRefundRoutes: ApplicationFeeRefundRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    public func create(fee: String, amount: Int?, metadata: [String: String]?) throws -> EventLoopFuture<StripeApplicationFeeRefund> {
        var body: [String: Any] = [:]
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.applicationFeeRefund(fee).endpoint, body: body.queryParameters)
    }
    
    public func retrieve(refund: String, fee: String) throws -> EventLoopFuture<StripeApplicationFeeRefund> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.applicationFeeRefunds(fee, refund).endpoint)
    }
    
    public func update(refund: String, fee: String, metadata: [String: String]?) throws -> EventLoopFuture<StripeApplicationFeeRefund> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.applicationFeeRefunds(fee, refund).endpoint, body: body.queryParameters)
    }
    
    public func listAll(fee: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeApplicationFeeList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return try request.send(method: .GET, path: StripeAPIEndpoint.applicationFeeRefund(fee).endpoint, query: queryParams)
    }
}
