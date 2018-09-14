//
//  Dispute.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/11/17.
//
//

import Foundation

/**
 Dispute object
 https://stripe.com/docs/api#dispute_object
 */
public struct StripeDispute: StripeModel {
    public var id: String
    public var object: String
    public var amount: Int?
    public var balanceTransactions: [StripeBalanceTransactionItem]?
    public var charge: String?
    public var created: Date?
    public var currency: StripeCurrency?
    public var evidence: StripeDisputeEvidence?
    public var evidenceDetails: StripeDisputeEvidenceDetails?
    public var isChargeRefundable: Bool?
    public var livemode: Bool?
    public var metadata: [String: String]
    public var reason: DisputeReason?
    public var status: DisputeStatus?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case balanceTransactions = "balance_transactions"
        case charge
        case created
        case currency
        case evidence
        case evidenceDetails = "evidence_details"
        case isChargeRefundable = "is_charge_refundable"
        case livemode
        case metadata
        case reason
        case status
    }
}
