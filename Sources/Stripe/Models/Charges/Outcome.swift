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
    case approvedByNetwork
    case declinedByNetwork
    case notSentToNetwork
    case reversedAfterApproval
    
    enum CodingKeys: String, CodingKey {
        case approvedByNetwork = "approved_by_network"
        case declinedByNetwork = "declined_by_network"
        case notSentToNetwork = "not_sent_to_network"
        case reversedAfterApproval = "reversed_after_approval"
    }
}

public enum RiskLevel: String, Codable {
    case normal
    case elevated
    case highest
    case notAssessed
    case unknown
    
    enum CodingKeys: String, CodingKey {
        case normal
        case elevated
        case highest
        case notAssessed = "not_assessed"
        case unknown
    }
}

public enum OutcomeType: String, Codable {
    case authorized
    case manualReview
    case issuerDeclined
    case blocked
    case invalid
    
    enum CodingKeys: String, CodingKey {
        case authorized
        case manualReview = "manual_review"
        case issuerDeclined = "issuer_declined"
        case blocked
        case invalid
    }
}

public protocol Outcome {
    var networkStatus: NetworkStatus? { get }
    var reason: String? { get }
    var riskLevel: RiskLevel? { get }
    var rule: String? { get }
    var sellerMessage: String? { get }
    var type: OutcomeType? { get }
}

public struct StripeOutcome: Outcome, StripeModel {
    public var networkStatus: NetworkStatus?
    public var reason: String?
    public var riskLevel: RiskLevel?
    public var rule: String?
    public var sellerMessage: String?
    public var type: OutcomeType?
    
    enum CodingKeys: String, CodingKey {
        case networkStatus = "network_status"
        case reason
        case riskLevel = "risk_level"
        case rule
        case sellerMessage = "seller_message"
        case type
    }
}
