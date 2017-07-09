//
//  AdditionalOwner.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation
import Vapor
import Helpers

public final class AdditionalOwner: StripeModelProtocol {
    
    public private(set) var firstName: String?
    public private(set) var lastName: String?
    public private(set) var dateOfBirth: Node?
    public private(set) var address: ShippingAddress?
    public private(set) var verification: Verification?
    
    public init(node: Node) throws {
        self.firstName = try node.get("first_name")
        self.lastName = try node.get("last_name")
        self.dateOfBirth = try node.get("dob")
        self.address = try node.get("address")
        self.verification = try node.get("verification")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "first_name": self.firstName,
            "last_name": self.lastName,
            "dob": self.dateOfBirth,
            "address": self.address,
            "verification": self.verification
        ]
        
        return try Node(node: object)
    }
}
