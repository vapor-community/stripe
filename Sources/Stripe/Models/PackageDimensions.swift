//
//  PackageDimensions.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Foundation
import Vapor

open class PackageDimensions: StripeModelProtocol {
    
    public private(set) var height: Decimal?
    public private(set) var length: Decimal?
    public private(set) var weight: Decimal?
    public private(set) var width: Decimal?
    
    public required init(node: Node) throws {
        
        self.height = try Decimal(node.get("height") as Int)
        self.length = try Decimal(node.get("length") as Int)
        self.weight = try Decimal(node.get("weight") as Int)
        self.width = try Decimal(node.get("width") as Int)
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "height": self.height,
            "length": self.length,
            "weight": self.weight,
            "width": self.width
        ]
        return try Node(node: object)
    }
}
