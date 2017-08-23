//
//  Inventory.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Foundation
import Vapor
import Helpers

public final class Inventory: StripeModelProtocol {
    
    public private(set) var quantity: Int?
    public private(set) var type: InventoryType?
    public private(set) var value: InventoryTypeValue?
    
    public init(node: Node) throws {
        self.quantity = try node.get("quantity")
        if let type = node["type"]?.string {
            self.type = InventoryType(rawValue: type)
        }
        if let value = node["value"]?.string {
            self.value = InventoryTypeValue(rawValue: value)
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "quantity": self.quantity,
            "type": self.type?.rawValue,
            "value": self.value?.rawValue
        ]
        return try Node(node: object)
    }
}
