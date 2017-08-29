//
//  SubscriptionItemRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/6/17.
//
//

import Foundation
import Node

import HTTP



public final class SubscriptionItemRoutes {
    
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Create SubscriptionItem 
     
      - parameter planId:           The identifier of the plan to add to the subscription.
     
      - parameter prorate:          Flag indicating whether to prorate switching plans during a billing cycle.
     
      - parameter prorationDate:    If set, the proration will be calculated as though the subscription was updated at the given time.
     
      - parameter quantity:         The quantity you’d like to apply to the subscription item you’re creating.
     
      - parameter subscriptionId:   The identifier of the subscription to modify.
     
      - returns: A StripeRequest<> item which you can then use to convert to the corresponding node.
     */
    
    public func create(planId: String, prorate: Bool, prorationDate: Date, quantity: Int, subscriptionId: String) throws -> StripeRequest<SubscriptionItem> {
        
        let body: [String: Any] = [
            "plan": planId,
            "subscription": subscriptionId,
            "prorate": prorate,
            "proration_date": Int(prorationDate.timeIntervalSince1970),
            "quantity": quantity
        ]
        
        let node = try Node(node: body)
        
        return try StripeRequest(client: self.client, method: .post, route: .subscriptionItem, query: [:], body: Body.data(node.formURLEncoded()), headers: nil)
    }
    
    /**
     Retrieve a subscriptionItem
     Retrieves the invoice item with the given ID.
     
     - parameter subscriptionId: The identifier of the subscription item to retrieve.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func retrieve(subscriptionItem subscriptionItemId: String) throws -> StripeRequest<SubscriptionItem> {
        return try StripeRequest(client: self.client, method: .get, route: .subscriptionItems(subscriptionItemId), query: [:], body: nil, headers: nil)
    }
    
    /**
     Update a subscription item
     Updates the plan or quantity of an item on a current subscription.
     
     - parameter plan: The identifier of the new plan for this subscription item.
     
     - parameter prorate: Flag indicating whether to prorate switching plans during a billing cycle.
     
     - parameter prorationDate: If set, the proration will be calculated as though the subscription was updated at the given time.
     
     - parameter quantity: The quantity you’d like to apply to the subscription item you’re creating.
     
     - parameter subscriptionItemId: The identifier of the subscription item to modify.
     */
    
    public func update(plan: String?, prorate: Bool?, prorationDate: Date?, quantity: Int?, subscriptionItemId: String) throws -> StripeRequest<SubscriptionItem> {
        var body = Node([:])
        
        if let plan = plan {
            body["plan"] = Node(plan)
        }
        
        if let prorate = prorate {
            body["prorate"] = Node(prorate)
        }
        if let prorationdate = prorationDate {
            body["proration_date"] = Node(Int(prorationdate.timeIntervalSince1970))
        }
        if let quantity = quantity {
            body["quantity"] = Node(quantity)
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .subscriptionItems(subscriptionItemId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Delete a subscription item
     Deletes an item from the subscription.
     
     - parameter subscriptionItemId: The identifier of the coupon to be deleted.
     
     - parameter prorate: Flag indicating whether to prorate switching plans during a billing cycle.
     
     - parameter prorationDate: If set, the proration will be calculated as though the subscription was updated at the given time.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func delete(subscriptionItem subscriptionItemId: String, prorate: Bool?, proprationDate: Date?) throws -> StripeRequest<SubscriptionItem> {
        
        var body = Node([:])
        
        if let prorate = prorate {
            body["prorate"] = Node(prorate)
        }
        if let prorationdate = proprationDate {
            body["proration_date"] = Node(Int(prorationdate.timeIntervalSince1970))
        }
        
        return try StripeRequest(client: self.client, method: .delete, route: .subscriptionItems(subscriptionItemId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }

    /**
     List all subscription items
     Returns a list of your subscription items for a given subscription.
     
     - parameter filter: A Filter item to pass query parameters when fetching results.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func listAll(subscriptionId: String, filter: StripeFilter?) throws -> StripeRequest<SubscriptionItemList> {
        var query = [String : NodeRepresentable]()
        
        if let data = try filter?.createQuery()
        {
            query = data
        }
        
        query["subscription"] = Node(subscriptionId)
        
        return try StripeRequest(client: self.client, method: .get, route: .subscriptionItem, query: query, body: nil, headers: nil)
    }
}
