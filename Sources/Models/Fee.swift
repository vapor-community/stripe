//
//  Fee.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor
import Helpers

public final class Fee: StripeModelProtocol {
    
    public let amount: Int
    public let currency: StripeCurrency
    public let description: String
    public let type: ActionType
    
    public init(node: Node) throws {
        self.amount = try node.get("amount")
        self.currency = try StripeCurrency(rawValue: node.get("currency"))!
        self.description = try node.get("description")
        self.type = try ActionType(rawValue: node.get("type"))!
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            "amount": self.amount,
            "currency": self.currency,
            "description": self.description,
            "type": self.type.rawValue
        ])
    }
    
}

