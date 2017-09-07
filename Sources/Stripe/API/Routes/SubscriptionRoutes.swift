//
//  SubscriptionRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/9/17.
//
//

import Foundation

import HTTP

import Node


public final class SubscriptionRoutes {
    
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Create a subscription
     Creates a new subscription on an existing customer.
     
     - parameter customerId: The identifier of the customer to subscribe.
     
     - parameter plan: The identifier of the plan to subscribe the customer to.
     
     - parameter applicationFeePercent: This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account. Must be a possitive integer betwee 0 and 100
     
     - parameter coupon: The code of the coupon to apply to this subscription.
     
     - parameter items: List of subscription items, each with an attached plan.
     
     - parameter quantity: The quantity you’d like to apply to the subscription you’re creating.
     
     - parameter source: The source can either be a token, like the ones returned by Elements, or a dictionary containing a user’s credit card details
     
     - parameter taxPercent: A non-negative decimal between 0 and 100.
     
     - parameter trialEnd: Unix timestamp representing the end of the trial period the customer will get before being charged for the first time.
     
     - parameter trialPeriodDays: Integer representing the number of trial period days before the customer is charged for the first time.
     
     - parameter metadata: A set of key/value pairs that you can attach to a subscription object.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     
    */
    
    public func create(forCustomer customerId: String, plan: String? = nil, applicationFeePercent: Int? = nil, ownerAccount: String? = nil, couponId: String? = nil, items: Node? = nil, quantity: Int? = nil, source: Node? = nil, taxPercent: Double? = nil, trialEnd: Date? = nil, trialPeriodDays: Int? = nil, metadata: Node? = nil) throws -> StripeRequest<Subscription> {
        
        var headers: [HeaderKey : String]?
        if let account = ownerAccount {
            headers = [
                StripeHeader.Account: account
            ]
        }
        
        var body = Node([:])
        body["customer"] = Node(customerId)
        
        if let plan = plan {
            body["plan"] = Node(plan)
        }
        
        if let appFeePercent = applicationFeePercent {
            body["application_fee_percent"] = Node(appFeePercent)
        }
        
        if let couponId = couponId {
            body["coupon"] = Node(couponId)
        }
        
        if let items = items?.array {
            
            for(index, item) in items.enumerated() {
                body["items[\(index)]"] = Node(item)
            }
        }
        
        if let quantity = quantity {
            body["quantity"] = Node(quantity)
        }
        
        /// source can either be a token or a dictionary
        if let sourceToken = source?.string {
            body["source"] = Node(sourceToken)
        }
        /** 
         Since source is passed to us we assume it's in a dictionary format with correct keys/values set as per the Stripe API
         So we just set the dictionary as the paramater because it's expecting that type anyway
         https://stripe.com/docs/api/curl#create_subscription
        */
        if let source = source?.object {
            
            body["source"] = Node(source)
        }
        if let tax = taxPercent {
            body["tax_percent"] = Node(tax)
        }
        if let trialEnd = trialEnd {
            body["trial_end"] = Node(Int(trialEnd.timeIntervalSince1970))
        }
        if let trialDays = trialPeriodDays {
            body["trial_period_days"] = Node(trialDays)
        }
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .subscription, query: [:], body: Body.data(body.formURLEncoded()), headers: headers)
    }
    
    /**
     Retrieve a subscription
     
     - parameter subscriptionId: The identifier of the source to be retrieved.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func retrieve(subscription subscriptionId: String) throws -> StripeRequest<Subscription> {
        return try StripeRequest(client: self.client, method: .get, route: .subscriptions(subscriptionId), query: [:], body: nil, headers: nil)
    }
    
    /**
     Update a subscription
     
     - parameter subscriptionId: The identifier of the subscription to update
     
     - parameter applicationFeePercent: This represents the percentage of the subscription invoice subtotal that will be transferred to the application owner’s Stripe account.
     
     - parameter coupon: The code of the coupon to apply to this subscription.
     
     - parameter items: List of subscription items, each with an attached plan.
     
     - parameter plan: The identifier of the plan to subscribe the customer to.
     
     - parameter prorate: Flag telling us whether to prorate switching plans during a billing cycle.
     
     - parameter prorationDate: If set, the proration will be calculated as though the subscription was updated at the given time.
     
     - parameter quantity: The quantity you’d like to apply to the subscription you’re creating.
     
     - parameter source: The source can either be a token, like the ones returned by Elements, or a dictionary containing a user’s credit card details
     
     - parameter taxPercent: A non-negative decimal between 0 and 100.
     
     - parameter trialEnd: Unix timestamp representing the end of the trial period the customer will get before being charged for the first time.
     
     - parameter metadata: A set of key/value pairs that you can attach to a subscription object.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     
     */
    
    public func update(subscription subscriptionId: String, applicationFeePercent: Double? = nil, couponId: String? = nil, items: Node? = nil, plan: String? = nil, prorate: Bool? = nil, quantity: Int? = nil, source: Node? = nil, taxPercent: Double? = nil, trialEnd: Date? = nil, metadata: Node? = nil) throws -> StripeRequest<Subscription> {
        var body = Node([:])
        
        if let plan = plan {
            body["plan"] = Node(plan)
        }
        
        if let appFeePercent = applicationFeePercent {
            body["application_fee_percent"] = Node(appFeePercent)
        }
        
        if let couponId = couponId {
            body["coupon"] = Node(couponId)
        }
        
        if let items = items?.array {
            
            for(index, item) in items.enumerated() {
                body["items[\(index)]"] = Node(item)
            }
        }
        
        if let prorate = prorate {
            body["prorate"] = Node(prorate)
        }
        
        if let quantity = quantity {
            body["quantity"] = Node(quantity)
        }
        /// source can either be a token or a dictionary
        if let sourceToken = source?.string {
            body["source"] = Node(sourceToken)
        }
        /**
         Since source is passed to us we assume it's in a dictionary format with correct keys/values set as per the Stripe API
         So we just set the dictionary as the paramater because it's expecting that type anyway
         https://stripe.com/docs/api/curl#create_subscription
         */
        if let source = source?.object {
            
            body["source"] = Node(source)
        }
        if let tax = taxPercent {
            body["tax_percent"] = Node(tax)
        }
        if let trialEnd = trialEnd {
            body["trial_end"] = Node(Int(trialEnd.timeIntervalSince1970))
        }
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        return try StripeRequest(client: self.client, method: .post, route: .subscriptions(subscriptionId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Delete a subscription discount
     Removes the currently applied discount on a subscription.
     
     - parameter subscriptionId: The Customer's ID
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func deleteDiscount(onSubscription subscriptionId: String) throws -> StripeRequest<DeletedObject> {
        return try StripeRequest(client: self.client, method: .delete, route: .subscriptionDiscount(subscriptionId), query: [:], body: nil, headers: nil)
    }
    
    /**
     Cancel a subscription
     
     - parameter subscriptionId: The identifier of the subscription to cancel
     
     - parameter atTrialEnd: A flag that if set to true will delay the cancellation of the subscription until the end of the current period.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func cancel(subscription subscriptionId: String, atPeriodEnd: Bool? = nil) throws -> StripeRequest<Subscription> {
        
        var body = Node([:])
        
        if let atperiodend = atPeriodEnd {
            body["at_period_end"] = Node(atperiodend)
        }
        
        return try StripeRequest(client: self.client, method: .delete, route: .subscriptions(subscriptionId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     List all customers
     By default, returns a list of subscriptions that have not been canceled.
     
     - parameter filter: A Filter item to pass query parameters when fetching results
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func listAll(filter: StripeFilter? = nil) throws -> StripeRequest<SubscriptionList> {
        var query = [String : NodeRepresentable]()
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .subscription, query: query, body: nil, headers: nil)
    }
}
