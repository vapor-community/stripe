//
//  FruadDetails.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

/**
 Fraud Details
 https://stripe.com/docs/api/curl#charge_object-fraud_details
 */

public enum FraudReport: String, Codable {
    case safe
    case fraudulent
}

public protocol FraudDetails {
    var userReport: FraudReport? { get }
    var stripeReport: FraudReport? { get }
}

public struct StripeFraudDetails: FraudDetails, StripeModel {
    public var userReport: FraudReport?
    public var stripeReport: FraudReport?
    
    public enum CodingKeys: String, CodingKey {
        case userReport = "user_report"
        case stripeReport = "stripe_report"
    }
}
