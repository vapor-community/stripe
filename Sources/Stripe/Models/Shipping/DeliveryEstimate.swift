//
//  DeliveryEstimate.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation
import Vapor

open class DeliveryEstimate: StripeModelProtocol {
    
    public private(set) var date: String?
    public private(set) var earliest: String?
    public private(set) var latest: String?
    public private(set) var type: DeliveryEstimateType?
    
    public required init(node: Node) throws {
        self.date = try node.get("date")
        self.earliest = try node.get("earliest")
        self.latest = try node.get("latest")
        if let type = node["type"]?.string {
            self.type = DeliveryEstimateType(rawValue: type)
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        
        let object: [String: Any?] = [
            "date": self.date,
            "earliest": self.earliest,
            "latest": self.latest,
            "type": self.type?.rawValue,
            ]
        return try Node(node: object)
    }
}
