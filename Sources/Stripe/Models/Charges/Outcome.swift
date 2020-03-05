//
//  Outcome.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

/**
 Outcome
 https://stripe.com/docs/api/curl#charge_object-outcome
 */

public enum NetworkStatus: String, Codable {
    case approvedByNetwork = "approved_by_network"
    case declinedByNetwork = "declined_by_network"
    case notSentToNetwork = "not_sent_to_network"
    case reversedAfterApproval = "reversed_after_approval"
}

public enum RiskLevel: String, Codable {
    case normal
    case elevated
    case highest
    case notAssessed = "not_assessed"
    case unknown
}

public enum OutcomeType: String, Codable {
    case authorized
    case manualReview = "manual_review"
    case issuerDeclined = "issuer_declined"
    case blocked
    case invalid
}

public struct StripeOutcome: StripeModel {
    public var networkStatus: NetworkStatus?
    public var reason: String?
    public var riskLevel: RiskLevel?
    public var rule: String?
    public var sellerMessage: String?
    public var type: OutcomeType?
    
    public enum CodingKeys: String, CodingKey {
        case networkStatus = "network_status"
        case reason
        case riskLevel = "risk_level"
        case rule
        case sellerMessage = "seller_message"
        case type
    }
}
