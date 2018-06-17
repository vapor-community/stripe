//
//  PlanRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/17.
//
//

import Vapor

public protocol PlanRoutes {
    func create(id: String?, currency: StripeCurrency, interval: StripePlanInterval, product: String, amount: Int?, intervalCount: Int?, metadata: [String: String]?, nickname: String?) throws -> Future<StripePlan>
    func retrieve(plan: String) throws -> Future<StripePlan>
    func update(plan: String, metadata: [String: String]?, nickname: String?, product: String?) throws -> Future<StripePlan>
    func delete(plan: String) throws -> Future<StripeDeletedObject>
    func listAll(filter: [String: Any]?) throws -> Future<PlansList>
}

public struct StripePlanRoutes: PlanRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    /// Create a plan
    /// [Learn More →](https://stripe.com/docs/api/curl#create_plan)
    public func create(id: String? = nil,
                       currency: StripeCurrency,
                       interval: StripePlanInterval,
                       product: String,
                       amount: Int? = nil,
                       intervalCount: Int? = nil,
                       metadata: [String: String]? = nil,
                       nickname: String? = nil) throws -> Future<StripePlan> {
        var body: [String: Any] = [:]
        
        body["currency"] = currency.rawValue
        body["interval"] = interval.rawValue
        body["product"] = product
        
        if let id = id {
            body["id"] = id
        }
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let intervalCount = intervalCount {
            body["interval_count"] = intervalCount
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let nickname = nickname {
            body["nickname"] = nickname
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.plans.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve a plan
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_plan)
    public func retrieve(plan: String) throws -> Future<StripePlan> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.plan(plan).endpoint)
    }
    
    /// Update a plan
    /// [Learn More →](https://stripe.com/docs/api/curl#update_plan)
    public func update(plan: String,
                       metadata: [String : String]? = nil,
                       nickname: String? = nil,
                       product: String? = nil) throws -> Future<StripePlan> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let nickname = nickname {
            body["nickname"] = nickname
        }
        
        if let product = product {
            body["product"] = product
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.plan(plan).endpoint, body: body.queryParameters)
    }
    
    /// Delete a plan
    /// [Learn More →](https://stripe.com/docs/api/curl#delete_plan)
    public func delete(plan: String) throws -> Future<StripeDeletedObject> {
        return try request.send(method: .DELETE, path: StripeAPIEndpoint.plan(plan).endpoint)
    }
    
    /// List all plans
    /// [Learn More →](https://stripe.com/docs/api/curl#list_plans)
    public func listAll(filter: [String : Any]? = nil) throws -> Future<PlansList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .GET, path: StripeAPIEndpoint.plans.endpoint, query: queryParams)
    }
}
