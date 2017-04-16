//
//  Balance.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Node

public final class Balance: StripeModelProtocol {

    public let object: String
    public let isLiveMode: Bool
    public let available: [Transfer]
    public let pending: [Transfer]

    public init(node: Node) throws {
        self.object = try node.get("object")
        self.isLiveMode = try node.get("livemode")
        self.available = try node.get("available")
        self.pending = try node.get("pending")
    }

    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            "object": self.object,
            "livemode": self.isLiveMode,
            "available": self.available,
            "pending": self.pending
        ])
    }

}
