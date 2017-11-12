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
open class Token: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var type: String?
    public private(set) var clientIp: String?
    public private(set) var created: Date?
    public private(set) var isLive: Bool?
    public private(set) var isUsed: Bool?
    
    public private(set) var card: Card?
    public private(set) var bankAccount: BankAccount?
    
    public required init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.type = try node.get("type")
        self.clientIp = try node.get("client_ip")
        self.created = try node.get("created")
        self.isLive = try node.get("livemode")
        self.isUsed = try node.get("used")
        self.card = try node.get("card")
        self.bankAccount = try node.get("bank_account")
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
            "card": self.card,
            "banl_account": self.bankAccount
        ]
        return try Node(node: object)
    }
    
}
