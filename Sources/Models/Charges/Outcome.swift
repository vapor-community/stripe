//
//  Outcome.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor
import Helpers

/**
 Outcome
 https://stripe.com/docs/api/curl#charge_object-outcome
 */
public enum NetworkStatus: String {
    case approvedByNetwork = "approved_by_network"
    case declinedByNetwork = "declined_by_network"
    case notSentToNetwork = "not_sent_to_network"
    case reversedAfterApproval = "reversed_after_approval"
}

public enum RiskLevel: String {
    case normal = "normal"
    case elevated = "elevated"
    case highest = "highest"
    case notAssessed = "not_assessed"
    case unknown = "unknown"
}

public enum OutcomeType: String {
    case authorized = "authorized"
    case manualReview = "manual_review"
    case issuerDeclined = "issuer_declined"
    case blocked = "blocked"
    case invalid = "invalid"
}

public final class Outcome: StripeModelProtocol {
    
    public private(set) var networkStatus: NetworkStatus?
    public private(set) var reason: String?
    public private(set) var riskLevel: RiskLevel?
    public private(set) var rule: String?
    public private(set) var sellerMessage: String?
    public private(set) var type: OutcomeType?
    
    public init(node: Node) throws {
        if let networkStatus = node["network_status"]?.string {
            self.networkStatus = NetworkStatus(rawValue: networkStatus)
        }
        self.reason = try node.get("reason")
        if let riskLevel = node["risk_level"]?.string {
            self.riskLevel = RiskLevel(rawValue: riskLevel)
        }
        self.rule = try node.get("rule")
        self.sellerMessage = try node.get("seller_message")
        if let outcome = node["type"]?.string {
            self.type = OutcomeType(rawValue: outcome)
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "network_status": self.networkStatus?.rawValue,
            "reason": self.reason ?? nil,
            "risk_level": self.riskLevel?.rawValue,
            "rule": self.rule ?? nil,
            "seller_message": self.sellerMessage,
            "type": self.type?.rawValue
        ]
        return try Node(node: object)
    }
}
