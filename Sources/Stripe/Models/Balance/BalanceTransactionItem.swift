//
//  BalanceTransactionItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor


public final class BalanceTransactionItem: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var amount: Int?
    public private(set) var availableOn: Date?
    public private(set) var created: Date?
    public private(set) var description: String?
    // AETODO add fee
    public private(set) var fees: [Fee]?
    public private(set) var net: Int?
    public private(set) var source: String?
    public private(set) var status: StripeStatus?
    public private(set) var type: ActionType?
    
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
        if let status = node["status"]?.string {
            self.status =  StripeStatus(rawValue: status)
        }
        if let type = node["type"]?.string {
            self.type = ActionType(rawValue: type)
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "id": self.id,
            "object": self.object,
            "amount": self.amount,
            "available_on": self.availableOn,
            "created": self.created,
            "description": self.description,
            "fee_details": self.fees,
            "net": self.net,
            "source": self.source,
            "status": self.status?.rawValue,
            "type": self.type?.rawValue
        ]
        return try Node(node: object)
    }
}
