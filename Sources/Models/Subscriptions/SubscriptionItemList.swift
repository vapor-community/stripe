//
//  SubscriptionItemList.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/8/17.
//
//

import Foundation
import Vapor
import Helpers

public final class SubscriptionItemList: StripeModelProtocol {
    
    public private(set) var object: String?
    public private(set) var hasMore: Bool?
    public private(set) var items: [SubscriptionItem]?
    public private(set) var url: String?
    public private(set) var totalCount: Int?
    
    public init(node: Node) throws {
        self.object = try node.get("object")
        self.hasMore = try node.get("has_more")
        self.items = try node.get("data")
        self.url = try node.get("url")
        self.totalCount = try node.get("total_count")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "object": self.object,
            "has_more": self.hasMore,
            "data": self.items,
            "url": self.url,
            "total_count": self.totalCount
        ]
        return try Node(node: object)
    }
}
