//
//  Source.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor
import Helpers

/*
 Source Model
 https://stripe.com/docs/api/curl#source_object
 */
public final class Source: StripeModelProtocol {
    
    public let id: String
    public let object: String
    public let amount: Int
    public let clientSecret: String
    public let created: Date
    public let currency: StripeCurrency?
    public let flow: String
    public let isLive: Bool
    public let status: StripeStatus?
    public let type: ActionType?
    public let usage: String
    public let metadata: [String : Any]
    public let owner: Owner?
    public let reciever: Receiver?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.amount = try node.get("amount")
        self.clientSecret = try node.get("client_secret")
        self.created = try node.get("created")
        self.currency = try StripeCurrency(rawValue: node.get("currency"))
        self.flow = try node.get("flow")
        self.isLive = try node.get("livemode")
        self.status = try StripeStatus(rawValue: node.get("status"))
        self.type = try ActionType(rawValue: node.get("type"))
        self.usage = try node.get("usage")
        self.metadata = try node.get("metadata")
        self.owner = try node.get("owner")
        self.reciever = try node.get("receiver")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "id": self.id,
            "object": self.object,
            "amount": self.amount,
            "client_secret": self.clientSecret,
            "created": self.created,
            "currency": self.currency?.rawValue,
            "flow": self.flow,
            "livemode": self.isLive,
            "status": self.status?.rawValue,
            "type": self.type?.rawValue,
            "usage": self.usage,
            "metadata": self.metadata,
            "owner": self.owner,
            "receiver": self.reciever
        ]
        return try Node(node: object)
    }
    
}
