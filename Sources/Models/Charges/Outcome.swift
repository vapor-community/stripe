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

/*
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
    
    public let networkStatus: NetworkStatus?
    public let reason: String?
    public let riskLevel: RiskLevel?
    public let rule: String?
    public let sellerMessage: String
    public let type: OutcomeType?
    
    public init(node: Node) throws {
        self.networkStatus = try NetworkStatus(rawValue: node.get("network_status"))
        self.reason = try node.get("reason")
        self.riskLevel = try RiskLevel(rawValue: node.get("risk_level"))
        self.rule = try node.get("rule")
        self.sellerMessage = try node.get("seller_message")
        self.type = try OutcomeType(rawValue: node.get("type"))
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [
            "network_status": self.networkStatus?.rawValue,
            "reason": self.reason ?? nil,
            "risk_level": self.riskLevel?.rawValue,
            "rule": self.rule ?? nil,
            "seller_message": self.sellerMessage,
            "type": self.type?.rawValue
        ])
    }
    
}
