//
//  Balance.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Node

public final class Balance: StripeModelProtocol {

    public private(set) var object: String?
    public private(set) var isLiveMode: Bool?
    public private(set) var available: [BalanceTransfer]?
    public private(set) var pending: [BalanceTransfer]?

    public init(node: Node) throws {
        self.object = try node.get("object")
        self.isLiveMode = try node.get("livemode")
        self.available = try node.get("available")
        self.pending = try node.get("pending")
    }

    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "object": self.object,
            "livemode": self.isLiveMode,
            "available": self.available,
            "pending": self.pending
        ]
       return try Node(node: object)
    }
}
