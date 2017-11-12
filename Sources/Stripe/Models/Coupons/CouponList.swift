//
//  CouponList.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/28/17.
//
//

import Foundation
import Vapor

open class CouponList: StripeModelProtocol {
    public private(set) var object: String?
    public private(set) var url: String?
    public private(set) var hasMore: Bool?
    public private(set) var items: [Coupon]?
    
    public required init(node: Node) throws {
        self.object = try node.get("object")
        self.url = try node.get("url")
        self.hasMore = try node.get("has_more")
        self.items = try node.get("data")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "object": self.object,
            "url": self.url,
            "has_more": self.hasMore,
            "data": self.items
        ]
        return try Node(node: object)
    }
}
