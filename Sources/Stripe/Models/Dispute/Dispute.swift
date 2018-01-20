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

public protocol Dispute {
    associatedtype BTI: BalanceTransactionItem
    associatedtype DE: DisputeEvidence
    associatedtype DED: DisputeEvidenceDetails
    
    var id: String? { get }
    var object: String? { get }
    var amount: Int? { get }
    var balanceTransactions: [BTI]? { get }
    var chargeId: String? { get }
    var created: Date? { get }
    var currency: StripeCurrency? { get }
    var evidence: DE? { get }
    var evidenceDetails: DED? { get }
    var isChargeRefundable: Bool? { get }
    var isLive: Bool? { get }
    var metadata: [String: String]? { get }
    var disputeReason: DisputeReason? { get }
    var disputeStatus: DisputeStatus? { get }
}

public struct StripeDispute: Dispute, StripeModel {
    public var id: String?
    public var object: String?
    public var amount: Int?
    public var balanceTransactions: [StripeBalanceTransactionItem]?
    public var chargeId: String?
    public var created: Date?
    public var currency: StripeCurrency?
    public var evidence: StripeDisputeEvidence?
    public var evidenceDetails: StripeDisputeEvidenceDetails?
    public var isChargeRefundable: Bool?
    public var isLive: Bool?
    public var metadata: [String: String]?
    public var disputeReason: DisputeReason?
    public var disputeStatus: DisputeStatus?
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case balanceTransactions = "balance_transactions"
        case chargeId = "charge"
        case created
        case currency
        case evidence
        case evidenceDetails = "evidence_details"
        case isChargeRefundable = "is_charge_refundable"
        case isLive = "livemode"
        case metadata
        case disputeReason = "reason"
        case disputeStatus = "status"
    }
}
