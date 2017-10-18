//
//  EphemeralKey.swift
//  Stripe
//
//  Created by Andrew Edwards on 10/17/17.
//

import Foundation
import Vapor

public final class EphemeralKey: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var associatedObjects: Node?
    public private(set) var created: Date?
    public private(set) var expires: Date?
    public private(set) var isLive: Bool?
    public private(set) var secret: String?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.associatedObjects = try node.get("associated_objects")
        self.created = try node.get("created")
        self.expires = try node.get("expires")
        self.isLive = try node.get("livemode")
        self.secret = try node.get("secret")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "associated_objects": self.associatedObjects,
            "created": self.created,
            "expires": self.expires,
            "livemode": self.isLive,
            "secret": self.isLive
        ]
        
        return try Node(node: object)
    }
}
