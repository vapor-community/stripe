//
//  CouponList.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/28/17.
//
//

import Foundation
import Vapor
import Helpers

public final class CouponList: StripeModelProtocol
{
    public let object: String
    public let url: String
    public let hasMore: Bool
    public let items: [Coupon]?
    
    public init(node: Node) throws
    {
        self.object = try node.get("object")
        self.url = try node.get("url")
        self.hasMore = try node.get("has_more")
        self.items = try node.get("data")
    }
    
    public func makeNode(in context: Context?) throws -> Node
    {
        let object: [String : Any?] = [
            "object": self.object,
            "url": self.url,
            "has_more": self.hasMore,
            "data": self.items
        ]
        return try Node(node: object)
    }
}
