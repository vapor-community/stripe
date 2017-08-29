//
//  Fee.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor

public final class Fee: StripeModelProtocol {
    
    public private(set) var amount: Int?
    public private(set) var currency: StripeCurrency?
    public private(set) var description: String?
    public private(set) var type: ActionType?
    
    public init(node: Node) throws {
        self.amount = try node.get("amount")
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        self.description = try node.get("description")
        if let type = node["type"]?.string {
            self.type = ActionType(rawValue: type)
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        
        let object: [String : Any?] = [
            "amount": self.amount,
            "currency": self.currency,
            "description": self.description,
            "type": self.type?.rawValue
        ]
        return try Node(node: object)
    }
}
