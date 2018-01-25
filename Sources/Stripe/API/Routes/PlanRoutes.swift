//
//  PlanRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/17.
//
//

import Vapor

public protocol PlanRoutes {
    associatedtype P: Plan
    associatedtype DO: DeletedObject
    associatedtype L: List
    
    func create(id: String?, currency: StripeCurrency, interval: StripePlanInterval, name: String, amount: Int?, intervalCount: Int?, metadata: [String: String]?, statementDescriptor: String?) throws -> Future<P>
    func retrieve(plan: String) throws -> Future<P>
    func update(plan: String, metadata: [String: String]?, name: String?, statementDescriptor: String?) throws -> Future<P>
    func delete(plan: String) throws -> Future<DO>
    func listAll(filter: [String: Any]?) throws -> Future<L>
}

public struct StripePlanRoutes<SR: StripeRequest>: PlanRoutes {
    private let request: SR
    
    init(request: SR) {
        self.request = request
    }
    
    /// Create a plan
    /// [Learn More →](https://stripe.com/docs/api/curl#create_plan)
    public func create(id: String? = nil,
                       currency: StripeCurrency,
                       interval: StripePlanInterval,
                       name: String,
                       amount: Int? = nil,
                       intervalCount: Int? = nil,
                       metadata: [String : String]? = nil,
                       statementDescriptor: String? = nil) throws -> Future<StripePlan> {
        var body: [String: Any] = [:]
        
        body["currency"] = currency.rawValue
        body["interval"] = interval.rawValue
        body["name"] = name
        
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
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        return try request.send(method: .post, path: StripeAPIEndpoint.plans.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve a plan
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_plan)
    public func retrieve(plan: String) throws -> Future<StripePlan> {
        return try request.send(method: .get, path: StripeAPIEndpoint.plan(plan).endpoint)
    }
    
    /// Update a plan
    /// [Learn More →](https://stripe.com/docs/api/curl#update_plan)
    public func update(plan: String,
                       metadata: [String : String]? = nil,
                       name: String? = nil,
                       statementDescriptor: String? = nil) throws -> Future<StripePlan> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let name = name {
            body["name"] = name
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        return try request.send(method: .post, path: StripeAPIEndpoint.plan(plan).endpoint, body: body.queryParameters)
    }
    
    /// Delete a plan
    /// [Learn More →](https://stripe.com/docs/api/curl#delete_plan)
    public func delete(plan: String) throws -> Future<StripeDeletedObject> {
        return try request.send(method: .delete, path: StripeAPIEndpoint.plan(plan).endpoint)
    }
    
    /// List all plans
    /// [Learn More →](https://stripe.com/docs/api/curl#list_plans)
    public func listAll(filter: [String : Any]? = nil) throws -> Future<PlansList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .get, path: StripeAPIEndpoint.plans.endpoint, query: queryParams)
    }
}
