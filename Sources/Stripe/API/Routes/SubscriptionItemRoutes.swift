//
//  SubscriptionItemRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/6/17.
//
//

import Vapor
import Foundation

public protocol SubscriptionItemRoutes {
    associatedtype SI: SubscriptionItem
    associatedtype L: List
    
    func create(plan: String, subscription: String, metadata: [String: String]?, prorate: Bool?, prorationDate: Date?, quantity: Int?) throws -> Future<SI>
    func retrieve(item: String) throws -> Future<SI>
    func update(item: String, metadata: [String: String]?, plan: String?, prorate: Bool?, prorationDate: Date?, quantity: Int?) throws -> Future<SI>
    func delete(item: String, prorate: Bool?, prorationDate: Date?) throws -> Future<SI>
    func listAll(subscription: String, filter: [String: Any]?) throws -> Future<L>
}

public struct StripeSubscriptionItemRoutes: SubscriptionItemRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }

    /// Create a subscription item
    /// [Learn More →](https://stripe.com/docs/api/curl#create_subscription_item)
    public func create(plan: String,
                       subscription: String,
                       metadata: [String : String]? = nil,
                       prorate: Bool? = nil,
                       prorationDate: Date? = nil,
                       quantity: Int? = nil) throws -> Future<StripeSubscriptionItem> {
        var body: [String: Any] = [:]
        
        body["plan"] = plan
        body["subscription"] = subscription
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let prorate = prorate {
            body["prorate"] = prorate
        }
        
        if let prorationDate = prorationDate {
            body["proration_date"] = Int(prorationDate.timeIntervalSince1970)
        }
        
        if let quantity = quantity {
            body["quantity"] = quantity
        }
        
        return try request.send(method: .post, path: StripeAPIEndpoint.subscriptionItem.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve a subscription item
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_subscription_item)
    public func retrieve(item: String) throws -> Future<StripeSubscriptionItem> {
        return try request.send(method: .get, path: StripeAPIEndpoint.subscriptionItems(item).endpoint)
    }
    
    /// Update a subscription item
    /// [Learn More →](https://stripe.com/docs/api/curl#update_subscription_item)
    public func update(item: String,
                       metadata: [String : String]? = nil,
                       plan: String? = nil,
                       prorate: Bool? = nil,
                       prorationDate: Date? = nil,
                       quantity: Int? = nil) throws -> Future<StripeSubscriptionItem> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let plan = plan {
            body["plan"] = plan
        }

        if let prorate = prorate {
            body["prorate"] = prorate
        }
        
        if let prorationDate = prorationDate {
            body["proration_date"] = Int(prorationDate.timeIntervalSince1970)
        }
        
        if let quantity = quantity {
            body["quantity"] = quantity
        }

        return try request.send(method: .post, path: StripeAPIEndpoint.subscriptionItems(item).endpoint, body: body.queryParameters)
    }
    
    /// Delete a subscription item
    /// [Learn More →](https://stripe.com/docs/api/curl#delete_subscription_item)
    public func delete(item: String,
                       prorate: Bool? = nil,
                       prorationDate: Date? = nil) throws -> Future<StripeSubscriptionItem> {
        var body: [String: Any] = [:]

        if let prorate = prorate {
            body["prorate"] = prorate
        }
        
        if let prorationDate = prorationDate {
            body["proration_date"] = Int(prorationDate.timeIntervalSince1970)
        }

        return try request.send(method: .delete, path: StripeAPIEndpoint.subscriptionItems(item).endpoint, body: body.queryParameters)
    }
    
    /// List all subscription items
    /// [Learn More →](https://stripe.com/docs/api/curl#list_subscription_item)
    public func listAll(subscription: String, filter: [String : Any]? = nil) throws -> Future<SubscriptionItemList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .get, path: StripeAPIEndpoint.subscriptionItems(subscription).endpoint, query: queryParams)
    }
}
