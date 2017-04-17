//
//  Filter.swift
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

public final class Filter {
    
    public init() {
        
    }
    
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
    
    
    internal func createBody() throws -> Node {
        var node = Node([:])
        if let value = self.created {
            node["created"] = value
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
            node["source"] = value.rawType.makeNode(in: nil)
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
        
        return node
    }
    
    internal func createQuery() throws -> [String : NodeRepresentable]? {
        return try self.createBody().object
    }
}
