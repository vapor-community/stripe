//
//  PlanRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/17.
//
//

import Foundation
import Node
import HTTP
import Models
import Helpers
import Errors

public final class PlanRoutes {
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Create a plan
     Creates a new plan object.
     
     - parameter id:                    Unique string of your choice that will be used to identify this plan when subscribing a customer.
                                        This could be an identifier like “gold” or a primary key from your own database.
     
     - parameter amount:                A positive integer in cents (or 0 for a free plan) representing how much to charge (on a recurring basis).
     
     - parameter currency:              The currency in which the charge will be under. (required if amount_off passed).
     
     - parameter interval:              Specifies billing frequency. Either day, week, month or year.
     
     - parameter name:                  Name of the plan, to be displayed on invoices and in the web interface.
     
     - parameter intervalCount:         The number of intervals between each subscription billing.
     
     - parameter metaData:              A set of key/value pairs that you can attach to a plan object.
     
     - parameter statementDescriptor:   An arbitrary string to be displayed on your customer’s credit card statement.
                                        This may be up to 22 characters.
     
     - parameter trialPeriodDays:       Specifies a trial period in (an integer number of) days.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node.
     */
    
    public func create(id: String, amount: Int, currency: StripeCurrency, interval: StripeInterval, name: String, intervalCount: Int?, metadata: Node?, statementDescriptor: String?, trialPeriodDays: Int?) throws -> StripeRequest<Coupon> {
        var body = Node([:])
        
        body["id"] = Node(id)
        
        body["amount"] = Node(amount)
        
        body["currency"] = Node(currency.rawValue)
        
        body["interval"] = Node(interval.rawValue)
        
        body["name"] = Node(name)
        
        if let intervalCount = intervalCount {
            body["interval_count"] = Node(intervalCount)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = Node(statementDescriptor)
        }
        
        if let trialPeriodDays = trialPeriodDays {
            body["trial_period_days"] = Node(trialPeriodDays)
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .plans, query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Retrieve a plan
     Retrieves the plan with the given ID.
     
     - parameter planId: The ID of the desired plan.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func retrieve(plan planId: String) throws -> StripeRequest<Plan> {
        return try StripeRequest(client: self.client, method: .get, route: .plan(planId), query: [:], body: nil, headers: nil)
    }
    
    /**
     Update a plan
     Updates the name or other attributes of a plan. Other plan details (price, interval, etc.) are, by design, not editable.
     
     - parameter metaData:              A set of key/value pairs that you can attach to a plan object.
     
     - parameter name:                  Name of the plan, to be displayed on invoices and in the web interface.
     
     - parameter statementDescriptor:   An arbitrary string to be displayed on your customer’s credit card statement.
     
     - parameter trialPeriodDays:       Specifies a trial period in (an integer number of) days.
     
     - parameter planId:                The identifier of the plan to be updated.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func update(metadata: Node?, name: String?, statementDescriptor: String?, trialPeriodDays: Int?, forPlanId planId: String) throws -> StripeRequest<Plan> {
        var body = Node([:])
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        if let name = name {
            body["name"] = Node(name)
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = Node(statementDescriptor)
        }
        
        if let trialPeriodDays = trialPeriodDays {
            body["trial_period_days"] = Node(trialPeriodDays)
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .plan(planId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Delete a plan
     Deleting a plan does not affect any current subscribers to the plan; it merely means that new subscribers can’t be added to that plan.
     
     - parameter couponId: The identifier of the plan to be deleted.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func delete(plan planId: String) throws -> StripeRequest<DeletedObject> {
        return try StripeRequest(client: self.client, method: .delete, route: .plan(planId), query: [:], body: nil, headers: nil)
    }
    
    /**
     List all plans
     Returns a list of your plans. The plans are returned sorted by creation date, with the
     most recent plans appearing first.
     
     - parameter filter: A Filter item to pass query parameters when fetching results.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func listAll(filter: StripeFilter?) throws -> StripeRequest<PlansList> {
        var query = [String : NodeRepresentable]()
        
        if let data = try filter?.createQuery() {
            query = data
        }
        
        return try StripeRequest(client: self.client, method: .get, route: .plans, query: query, body: nil, headers: nil)
    }
}
