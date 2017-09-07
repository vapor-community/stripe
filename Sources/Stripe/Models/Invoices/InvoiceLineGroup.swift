//
//  InvoiceLineGroup.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/5/17.
//
//

import Foundation
import Vapor

public final class InvoiceLineGroup: StripeModelProtocol {
    
    public private(set) var object: String?
    public private(set) var hasMore: Bool?
    public private(set) var items: [InvoiceLineItem]?
    
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
