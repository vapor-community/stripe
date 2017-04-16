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

    public let userReport: FraudReport?
    public let stripeReport: FraudReport?
    
    public init(node: Node) throws {
        self.userReport = try FraudReport(rawValue: node.get("user_report"))!
        self.stripeReport = try FraudReport(rawValue: node.get("stripe_report"))!
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            "user_report": self.userReport?.rawValue,
            "stripe_report": self.stripeReport?.rawValue
        ])
    }
    
}
