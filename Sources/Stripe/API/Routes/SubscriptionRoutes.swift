//
//  SubscriptionRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/9/17.
//
//

import Vapor
import Foundation
// TODO: Support sources being different objects
public protocol SubscriptionRoutes {
    associatedtype SB: Subscription
    associatedtype L: List
    associatedtype DO: DeletedObject
    
    func create(customer: String, applicationFeePercent: Decimal?, billing: String?, billingCycleAnchor: Date?, coupon: String?, daysUntilDue: Int?, items: [String: Any]?, metadata: [String: String]?, source: Any?, taxPercent: Decimal?, trialEnd: Any?, trialPeriodDays: Int?) throws -> Future<SB>
    func retrieve(id: String) throws -> Future<SB>
    func update(subscription: String, applicationFeePercent: Decimal?, billing: String?, billingCycleAnchor: String?, coupon: String?, daysUntilDue: Int?, items: [String: Any]?, metadata: [String: String]?, prorate: Bool?, prorationDate: Date?, source: Any?, taxPercent: Decimal?, trialEnd: Any?) throws -> Future<SB>
    func cancel(subscription: String, atPeriodEnd: Bool?) throws -> Future<SB>
    func listAll(filter: [String: Any]?) throws -> Future<L>
    func deleteDiscount(subscription: String) throws -> Future<DO>
}

public struct StripeSubscriptionRoutes: SubscriptionRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }

    /// Create a subscription
    /// [Learn More →](https://stripe.com/docs/api/curl#create_subscription)
    public func create(customer: String,
                       applicationFeePercent: Decimal? = nil,
                       billing: String? = nil,
                       billingCycleAnchor: Date? = nil,
                       coupon: String? = nil,
                       daysUntilDue: Int? = nil,
                       items: [[String : Any]]? = nil,
                       metadata: [String : String]? = nil,
                       source: Any? = nil,
                       taxPercent: Decimal? = nil,
                       trialEnd: Any? = nil,
                       trialPeriodDays: Int? = nil) throws -> Future<StripeSubscription> {
        var body: [String: Any] = [:]
        
        body["customer"] = customer
        
        if let applicationFeePercent = applicationFeePercent {
            body["application_fee_percent"] = applicationFeePercent
        }
        
        if let billing = billing {
            body["billing"] = billing
        }
        
        if let billingCycleAnchor = billingCycleAnchor {
            body["billing_cycle_anchor"] = Int(billingCycleAnchor.timeIntervalSince1970)
        }
        
        if let coupon = coupon {
            body["coupon"] = coupon
        }
        
        if let daysUntilDue = daysUntilDue {
            body["days_until_due"] = daysUntilDue
        }
        
        if let items = items {
            for (index, item) in items.enumerated() {
                item.forEach { body["items[\(index)][\($0)]"] = $1 }
            }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let source = source as? String {
            body["source"] = source
        }
        
        if let source = source as? [String: Any] {
            source.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let taxPercent = taxPercent {
            body["tax_percent"] = taxPercent
        }
        
        if let trialEnd = trialEnd as? Date {
            body["trial_end"] = Int(trialEnd.timeIntervalSince1970)
        }
        
        if let trialEnd = trialEnd as? String {
            body["trial_end"] = trialEnd
        }
        
        if let trialPeriodDays = trialPeriodDays {
            body["trial_period_days"] = trialPeriodDays
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.subscription.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve a subscription
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_subscription)
    public func retrieve(id: String) throws -> Future<StripeSubscription> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.subscriptions(id).endpoint)
    }
    
    /// Update a subscription
    /// [Learn More →](https://stripe.com/docs/api/curl#update_subscription)
    public func update(subscription: String,
                       applicationFeePercent: Decimal? = nil,
                       billing: String? = nil,
                       billingCycleAnchor: String? = nil,
                       coupon: String? = nil,
                       daysUntilDue: Int? = nil,
                       items: [[String : Any]]? = nil,
                       metadata: [String : String]? = nil,
                       prorate: Bool? = nil,
                       prorationDate: Date? = nil,
                       source: Any? = nil,
                       taxPercent: Decimal? = nil,
                       trialEnd: Any? = nil) throws -> Future<StripeSubscription> {
        var body: [String: Any] = [:]
        
        if let applicationFeePercent = applicationFeePercent {
            body["application_fee_percent"] = applicationFeePercent
        }
        
        if let billing = billing {
            body["billing"] = billing
        }
        
        if let billingCycleAnchor = billingCycleAnchor {
            body["billing_cycle_anchor"] = billingCycleAnchor
        }
        
        if let coupon = coupon {
            body["coupon"] = coupon
        }
        
        if let daysUntilDue = daysUntilDue {
            body["days_until_due"] = daysUntilDue
        }
        
        if let items = items {
            for (index, item) in items.enumerated() {
                item.forEach { body["items[\(index)][\($0)]"] = $1 }
            }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let prorate = prorate {
            body["prorate"] = prorate
        }
        
        if let prorationDate = prorationDate {
            body["proration_date"] = Int(prorationDate.timeIntervalSince1970)
        }
        
        if let source = source as? String {
            body["source"] = source
        }
        
        if let source = source as? [String: Any] {
            source.forEach { body["source[\($0)]"] = $1 }
        }
        
        if let taxPercent = taxPercent {
            body["tax_percent"] = taxPercent
        }
        
        if let trialEnd = trialEnd as? Date {
            body["trial_end"] = Int(trialEnd.timeIntervalSince1970)
        }
        
        if let trialEnd = trialEnd as? String {
            body["trial_end"] = trialEnd
        }

        return try request.send(method: .POST, path: StripeAPIEndpoint.subscriptions(subscription).endpoint, body: body.queryParameters)
    }
    
    /// Cancel a subscription
    /// [Learn More →](https://stripe.com/docs/api/curl#cancel_subscription)
    public func cancel(subscription: String, atPeriodEnd: Bool? = nil) throws -> Future<StripeSubscription> {
        var body: [String: Any] = [:]
        
        if let atPeriodEnd = atPeriodEnd {
            body["at_period_end"] = atPeriodEnd
        }
        
        return try request.send(method: .DELETE, path: StripeAPIEndpoint.subscriptions(subscription).endpoint, body: body.queryParameters)
    }
    
    /// List subscriptions
    /// [Learn More →](https://stripe.com/docs/api/curl#list_subscriptions)
    public func listAll(filter: [String : Any]? = nil) throws -> Future<SubscriptionList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .GET, path: StripeAPIEndpoint.subscription.endpoint, query: queryParams)
    }
    
    /// Delete a subscription discount
    /// [Learn More →](https://stripe.com/docs/api/curl#delete_subscription_discount)
    public func deleteDiscount(subscription: String) throws -> Future<StripeDeletedObject> {
        return try request.send(method: .DELETE, path: StripeAPIEndpoint.subscriptionDiscount(subscription).endpoint)
    }
}
