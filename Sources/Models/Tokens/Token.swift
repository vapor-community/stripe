//
//  Token.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/23/17.
//
//

import Vapor

/**
 Token Model
 https://stripe.com/docs/api/curl#token_object
 */
public final class Token: StripeModelProtocol {
    
    public let id: String
    public let object: String
    public let type: String
    public let clientIp: String?
    public let created: Date
    public let isLive: Bool
    public let isUsed: Bool
    
    public private(set) var card: Card?
    public private(set) var bankAccount: BankAccount?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.type = try node.get("type")
        self.clientIp = try node.get("client_ip")
        self.created = try node.get("created")
        self.isLive = try node.get("livemode")
        self.isUsed = try node.get("used")
        
        if let _ = node["card"] {
            self.card = try node.get("card")
        }
        
        if let _ = node["bank_account"] {
            self.bankAccount = try node.get("bank_account")
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        var object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "type": self.type,
            "client_ip": self.clientIp,
            "created": self.created,
            "livemode": self.isLive,
            "used": self.isUsed
        ]
        
        if let value = self.card {
            object["card"] = value
        }
        
        if let value = self.bankAccount {
            object["bank_account"] = value
        }
        
        return try Node(node: object)
    }
    
}
