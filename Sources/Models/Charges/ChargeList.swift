//
//  ChargeList.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/17/17.
//
//

import Foundation
import Vapor

public final class ChargeList: StripeModelProtocol {
    
    public let object: String
    public let hasMore: Bool
    public let items: [Charge]
    
    public init(node: Node) throws {
        self.object = try node.get("object")
        self.hasMore = try node.get("has_more")
        self.items = try node.get("data")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            "object": self.object,
            "has_more": self.hasMore,
            "data": self.items
        ])
    }
    
}

