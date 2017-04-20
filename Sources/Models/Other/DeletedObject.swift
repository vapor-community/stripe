//
//  DeletedObject.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//

import Foundation
import Vapor
import Helpers

public final class DeletedObject: StripeModelProtocol {
    
    public private(set) var deleted: Bool?
    public private(set) var id: String?
    
    public init(node: Node) throws {
        self.deleted = try node.get("deleted")
        self.id = try node.get("id")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "deleted": self.deleted,
            "id": self.id
        ]
        return try Node(node: object)
    }
    
}
