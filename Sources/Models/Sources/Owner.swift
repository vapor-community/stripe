//
//  Owner.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import Foundation
import Vapor
import Helpers

public final class Owner: StripeModelProtocol {
    
    public let address: String?
    public let email: String?
    public let name: String?
    public let phone: String?
    
    public init(node: Node) throws {
        self.address = try node.get("address")
        self.email = try node.get("email")
        self.name = try node.get("name")
        self.phone = try node.get("phone")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "address": self.address,
            "email": self.email,
            "name": self.name,
            "phone": self.phone
        ]
        return try Node(node: object)
    }
    
}
