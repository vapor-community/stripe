//
//  Token.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/23/17.
//
//

import Vapor

/*
 Token Model
 https://stripe.com/docs/api/curl#token_object
 */
public final class Token: StripeModelProtocol {
    
    let id: String
    let object: String
    let type: String
    let clientIp: String?
    let created: Date
    let isLive: Bool
    let isUsed: Bool
    
    let card: Card?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.type = try node.get("type")
        self.clientIp = try node.get("client_ip")
        self.created = try node.get("created")
        self.isLive = try node.get("livemode")
        self.isUsed = try node.get("used")
        
        self.card = try node.get("card")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "type": self.type,
            "client_ip": self.clientIp,
            "created": self.created,
            "livemode": self.isLive,
            "used": self.isUsed,
            "card": self.card
        ]
        return try Node(node: object)
    }
    
}
