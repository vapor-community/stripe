//
//  Refund.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor
import Helpers

/**
 Refunds
 https://stripe.com/docs/api/curl#charge_object-refunds
 */

public final class Refund: StripeModelProtocol {
    
    public private(set) var object: String?
    public private(set) var hasMore: Bool
    public private(set) var totalCount: Int?
    public private(set) var url: String?
    public private(set) var items: [RefundItem]?
    
    public init(node: Node) throws {
        self.object = try node.get("object")
        self.items = try node.get("data")
        self.hasMore = try node.get("has_more")
        self.totalCount = try node.get("total_count")
        self.url = try node.get("url")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "object": self.object,
            "data": self.items,
            "has_more": self.hasMore,
            "total_count": self.totalCount,
            "url": self.url
        ]
        return try Node(node: object)
    }
    
}
