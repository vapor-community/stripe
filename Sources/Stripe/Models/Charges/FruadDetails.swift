//
//  FruadDetails.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor


/**
 Fraud Details
 https://stripe.com/docs/api/curl#charge_object-fraud_details
 */
public enum FraudReport: String {
    case safe = "safe"
    case fraudulent = "fraudulent"
}

open class FraudDetails: StripeModelProtocol {

    public private(set) var userReport: FraudReport?
    public private(set) var stripeReport: FraudReport?
    
    public required init(node: Node) throws {
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
        let object: [String : Any?] = [
            "user_report": self.userReport?.rawValue,
            "stripe_report": self.stripeReport?.rawValue
        ]
        return try Node(node: object)
    }
}
