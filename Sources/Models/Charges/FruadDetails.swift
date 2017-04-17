//
//  FruadDetails.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor
import Helpers

/*
 Fraud Details
 https://stripe.com/docs/api/curl#charge_object-fraud_details
 */
public enum FraudReport: String {
    case safe = "safe"
    case fraudulent = "fraudulent"
}

public final class FraudDetails: StripeModelProtocol {

    public var userReport: FraudReport?
    public var stripeReport: FraudReport?
    
    public init(node: Node) throws {
        if let value: String? = try node.get("user_report") {
            if let value = value {
                self.userReport = FraudReport(rawValue: value)
            }
        }
        
        if let value: String? = try node.get("stripe_report") {
            if let value = value {
                self.stripeReport = FraudReport(rawValue: value)
            }
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            "user_report": self.userReport?.rawValue,
            "stripe_report": self.stripeReport?.rawValue
        ])
    }
    
}
