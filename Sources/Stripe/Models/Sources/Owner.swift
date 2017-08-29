//
//  Owner.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import Foundation
import Vapor


public final class Owner: StripeModelProtocol {
    public private(set) var address: ShippingAddress?
    public private(set) var email: String?
    public private(set) var name: String?
    public private(set) var phone: String?
    public private(set) var verifiedAddress: ShippingAddress?
    public private(set) var verifiedEmail: String?
    public private(set) var verifiedName: String?
    public private(set) var verifiedPhone: String?
    
    public init(node: Node) throws {
        self.address = try node.get("address")
        self.email = try node.get("email")
        self.name = try node.get("name")
        self.phone = try node.get("phone")
        self.verifiedAddress = try node.get("verified_address")
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
