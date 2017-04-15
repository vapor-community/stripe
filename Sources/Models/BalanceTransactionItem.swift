//
//  BalanceTransactionItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor
import Helpers

public final class BalanceTransactionItem: StripeModelProtocol {
    
    public let id: String
    public let object: String
    public let amount: Int
    public let availableOn: Date
    public let created: Date
    public let description: String
    public let fees: [Fee]
    public let net: Int
    public let source: String
    public let status: StripeStatus
    public let type: ActionType
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.amount = try node.get("amount")
        self.availableOn = try node.get("available_on")
        self.created = try node.get("created")
        self.description = try node.get("description")
        self.fees = try node.get("fee_details")
        self.net = try node.get("net")
        self.source = try node.get("source")
        self.status = try StripeStatus(rawValue: node.get("status"))!
        self.type = try ActionType(rawValue: node.get("type"))!
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            "id": self.id,
            "object": self.object,
            "amount": self.amount,
            "available_on": self.availableOn,
            "created": self.created,
            "description": self.description,
            "fee_details": self.fees,
            "net": self.net,
            "source": self.source,
            "status": self.status.rawValue,
            "type": self.type.rawValue
        ])
    }
    
}

