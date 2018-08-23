//
//  PayoutRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/20/18.
//

import Vapor
import Foundation

public protocol PayoutRoutes {
    func create(amount: Int, currency: StripeCurrency, description: String?, destination: String?, metadata: [String: String]?, method: StripePayoutMethod?, sourceType: StripePayoutSourceType?, statementDescriptor: String?) throws -> Future<StripePayout>
    func retrieve(payout: String) throws -> Future<StripePayout>
    func update(payout: String, metadata: [String: String]?) throws -> Future<StripePayout>
    func listAll(filter: [String: Any]?) throws -> Future<StripePayoutsList>
    func cancel(payout: String) throws -> Future<StripePayout>
}

extension PayoutRoutes {
    func create(amount: Int,
                currency: StripeCurrency,
                description: String? = nil,
                destination: String? = nil,
                metadata: [String: String]? = nil,
                method: StripePayoutMethod? = nil,
                sourceType: StripePayoutSourceType? = nil,
                statementDescriptor: String? = nil) throws -> Future<StripePayout> {
        return try create(amount: amount,
                          currency: currency,
                          description: description,
                          destination: destination,
                          metadata: metadata,
                          method: method,
                          sourceType: sourceType,
                          statementDescriptor: statementDescriptor)
    }
    
    func retrieve(payout: String) throws -> Future<StripePayout> {
        return try retrieve(payout: payout)
    }
    
    func update(payout: String, metadata: [String: String]? = nil) throws -> Future<StripePayout> {
        return try update(payout: payout, metadata: metadata)
    }
    
    func listAll(filter: [String: Any]? = nil) throws -> Future<StripePayoutsList> {
        return try listAll(filter: filter)
    }
    
    func cancel(payout: String) throws -> Future<StripePayout> {
        return try cancel(payout: payout)
    }
}

public struct StripePayoutRoutes: PayoutRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    /// Create a payout
    /// [Learn More →](https://stripe.com/docs/api/curl#create_payout)
    public func create(amount: Int,
                       currency: StripeCurrency,
                       description: String?,
                       destination: String?,
                       metadata: [String: String]?,
                       method: StripePayoutMethod?,
                       sourceType: StripePayoutSourceType?,
                       statementDescriptor: String?) throws -> Future<StripePayout> {
        var body: [String: Any] = [:]
        
        body["amount"] = amount
        body["currency"] = currency.rawValue
        
        if let description = description {
            body["description"] = description
        }
        
        if let destination = destination {
            body["destination"] = destination
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let method = method {
            body["method"] = method.rawValue
        }
        
        if let sourceType = sourceType {
            body["source_type"] = sourceType.rawValue
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.payout.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve a payout
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_payout)
    public func retrieve(payout: String) throws -> Future<StripePayout> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.payouts(payout).endpoint)
    }
    
    /// Update a payout
    /// [Learn More →](https://stripe.com/docs/api/curl#update_payout)
    public func update(payout: String, metadata: [String: String]?) throws -> Future<StripePayout> {
        var body: [String: Any] = [:]
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        return try request.send(method: .POST, path: StripeAPIEndpoint.payouts(payout).endpoint, body: body.queryParameters)
    }
    
    /// List payouts
    /// [Learn More →](https://stripe.com/docs/api/curl#list_payouts)
    public func listAll(filter: [String : Any]?) throws -> Future<StripePayoutsList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .GET, path: StripeAPIEndpoint.payout.endpoint, query: queryParams)
    }
    
    /// Cancel payout
    /// [Learn More →](https://stripe.com/docs/api/curl#cancel_payout)
    public func cancel(payout: String) throws -> Future<StripePayout> {
        return try request.send(method: .POST, path: StripeAPIEndpoint.payoutsCancel(payout).endpoint)
    }
}
