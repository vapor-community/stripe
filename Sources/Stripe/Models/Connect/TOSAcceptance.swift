//
//  TOSAcceptance.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation
import Vapor

open class TOSAcceptance: StripeModelProtocol {
    
    public private(set) var timestamp: Date?
    public private(set) var ip: String?
    public private(set) var userAgent: String?
    
    public required init(node: Node) throws {
        self.timestamp = try node.get("timestamp")
        self.ip = try node.get("ip")
        self.userAgent = try node.get("user_agent")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "timestamp": self.timestamp,
            "ip": self.ip,
            "user_agent": self.userAgent
        ]
        
        return try Node(node: object)
    }
}
