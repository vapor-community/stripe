//
//  ConnectLoginLink.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/9/17.
//
//

import Foundation
import Vapor

open class ConnectLoginLink: StripeModelProtocol {
    
    public private(set) var object: String?
    public private(set) var created: Date?
    public private(set) var url: String?
    
    public required init(node: Node) throws {
        self.object = try node.get("object")
        self.created = try node.get("created")
        self.url = try node.get("url")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "object": self.object,
            "created": self.created,
            "url": self.url
        ]
        
        return try Node(node: object)
    }
}
