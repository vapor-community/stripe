//
//  SubscriptionList.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//

import Foundation
import Vapor
import Helpers

public final class SubscriptionList: StripeModelProtocol {
    
    public private(set) var object: String?
    public private(set) var hasMore: Bool?
    public private(set) var items: [Any?]?
    
    public init(node: Node) throws {
        self.object = try node.get("object")
        self.hasMore = try node.get("has_more")
        self.items = try node.get("data")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "object": self.object,
            "has_more": self.hasMore,
            "data": self.items
        ]
        return try Node(node: object)
    }
    
}
