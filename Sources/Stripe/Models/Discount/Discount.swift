//
//  File.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/7/17.
//
//

import Foundation
import Vapor

/**
 Discount Model
 https://stripe.com/docs/api/curl#discount_object
 */
public final class Discount: StripeModelProtocol {
    
    public private(set) var object: String?
    public private(set) var coupon: Coupon?
    public private(set) var customer: String?
    public private(set) var end: Date?
    public private(set) var start: Date?
    public private(set) var subscription: String?
    
    
    public init(node: Node) throws {
        
        self.object = try node.get("object")
        self.coupon = try node.get("coupon")
        self.customer = try node.get("customer")
        self.end = try node.get("end")
        self.start = try node.get("start")
        self.subscription = try node.get("subscription")
    }
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "object": self.object,
            "coupon": self.coupon,
            "customer": self.customer,
            "end": self.end,
            "start": self.start,
            "subscription": self.subscription
        ]
        
        return try Node(node: object)
    }
}
