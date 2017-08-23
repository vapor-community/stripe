//
//  StripeFilter.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import Foundation
import Vapor
import Helpers
import Node
import HTTP

public final class StripeFilter {
    
    public init() { }
    
    /**
     Can either be a UNIX timestamp, or a dictionary with these key/values
     
     - gt:  Return values where the created field is after this timestamp.
     - gte: Return values where the created field is after or equal to this timestamp.
     - lt:  Return values where the created field is before this timestamp.
     - lte: Return values where the created field is before or equal to this timestamp.
     
     Example: 
     created = Node(node: ["UNIX_TIMESTAMP": "gte"])
     or
     created = Node(node: UNIX_TIMESTAMP)
     */
    public var created: Node?
    
    /**
     Can either be a UNIX timestamp, or a dictionary with these key/values
     
     - gt:  Return values where the created field is after this timestamp.
     - gte: Return values where the created field is after or equal to this timestamp.
     - lt:  Return values where the created field is before this timestamp.
     - lte: Return values where the created field is before or equal to this timestamp.
     
     Example:
     availableOn = Node(node: ["UNIX_TIMESTAMP": "gte"])
     or
     availableOn = Node(node: UNIX_TIMESTAMP)
     */
    public var availableOn: Node?
    
    /**
     A currency
     */
    public var currency: StripeCurrency?
    
    /**
     Only return charges for the customer specified by this customer ID.
    */
    public var customerId: Node?
    
    /**
     A cursor for use in pagination. `ending_before` is an object ID that defines your place in the list.
     For instance, if you make a list request and receive 100 objects, starting with `obj_bar`, your
     subsequent call can include `ending_before=obj_bar` in order to fetch the previous page of the list.
     
     Example: endingBefore = "obj_bar"
    */
    public var endingBefore: Node?
    
    /**
     A limit on the number of objects to be returned. Limit can range between 1 and 100 items.
     This field MUST be a possitive Integer or String. Default is 10
    */
    public var limit: Node?
    
    /**
     A filter on the list based on the source of the charge.
     */
    public var source: SourceType?
    
    /**
     A cursor for use in pagination. `starting_after` is an object ID that defines your place in the list.
     For instance, if you make a list request and receive 100 objects, ending with `obj_foo`, your
     subsequent call can include `starting_after=obj_foo` in order to fetch the next page of the list.
     
     Example: startingAfter = "obj_foo"
     */
    public var startingAfter: Node?
    
    /**
     Only return charges for this transfer group.
     */
    public var transferGroup: Node?
    
    /**
     For automatic Stripe payouts only, only returns transactions that were payed out on the specified payout ID.
     */
    public var payout: Node?
    
    /**
     Only returns transactions of the given type. One of BalanceType
    */
    public var balanceType: BalanceType?
    
    /**
     The status of the subscriptions to retrieve.
     */
    public var subscriptionStatus: StripeSubscriptionStatus?
    
    /**
     The ID of the plan whose subscriptions will be retrieved.
     */
    public var plan: Node?
    
    /**
     Only return SKUs that have the specified key/value pairs in this partially constructed dictionary.
     */
    public var attributes: Node?
    
    /**
     Only return SKUs that are active or inactive
     Also used for products.
     */
    public var active: Node?
    
    /**
     Only return SKUs that are either in stock or out of stock
     */
    public var inStock: Node?
    
    /**
     The ID of the product whose SKUs will be retrieved.
     */
    public var product: Node?
    
    /**
     Only return products that can be shipped (i.e., physical, not digital products).
     */
    public var shippable: Node?
    
    /**
     Only return products with the given url.
     */
    public var url: Node?
    
    internal func createBody() throws -> Node {
        var node = Node([:])
        if let value = self.created {
            if let value = value.object {
                for (key, value) in value {
                    node["created[\(key)]"] = value
                }
            } else {
                node["created"] = value
            }
        }
        
        if let value = self.availableOn {
            if let value = value.object {
                for (key, value) in value {
                    node["available_on[\(key)]"] = value
                }
            } else {
                node["available_on"] = value
            }
        }
        
        if let value = self.currency
        {
            node["currency"] = value.rawValue.makeNode(in: nil)
        }
        
        if let value = self.customerId {
            node["customer"] = value
        }
        
        if let value = self.endingBefore {
            node["ending_before"] = value
        }
        
        if let value = self.limit {
            node["limit"] = value
        }
        
        if let value = self.source {
            node["source"] = value.rawValue.makeNode(in: nil)
        }
        
        if let value = self.startingAfter {
            node["starting_after"] = value
        }
        
        if let value = self.transferGroup {
            node["transfer_group"] = value
        }
        
        if let value = self.payout {
            node["payout"] = value
        }
        
        if let value = self.balanceType {
            node["type"] = value.rawValue.makeNode(in: nil)
        }
        
        if let value = self.subscriptionStatus {
            node["status"] = value.rawValue.makeNode(in: nil)
        }
        
        if let value = self.plan {
            node["plan"] = value
        }
        
        if let value = attributes?.object {
            for (key, value) in value {
                node["attributes[\(key)]"] = value
            }
        }
        
        if let shippable = self.shippable {
            node["shippable"] = shippable
        }
        
        if let url = self.url {
            node["url"] = url
        }
        
        return node
    }
    
    internal func createQuery() throws -> [String : NodeRepresentable]? {
        return try self.createBody().object
    }
}
