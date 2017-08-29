//
//  StatusTransitions.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation
import Vapor


public final class StatusTransitions: StripeModelProtocol {
    
    public private(set) var canceled: Date?
    public private(set) var fufilled: Date?
    public private(set) var paid: Date?
    public private(set) var returned: Date?
    
    public init(node: Node) throws {
        self.canceled = try node.get("canceled")
        self.fufilled = try node.get("fufilled")
        self.paid = try node.get("paid")
        self.returned = try node.get("returned")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        
        let object: [String: Any?] = [
            "canceled": self.canceled,
            "fufilled": self.fufilled,
            "paid": self.paid,
            "returned": self.returned,
            ]
        return try Node(node: object)
    }
}
