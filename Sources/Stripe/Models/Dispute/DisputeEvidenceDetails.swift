//
//  DisputeEvidenceDetails.swift
//  Stripe
//
//  Created by Andrew Edwards on 12/7/17.
//

import Foundation

/**
 DisputeEvidenceDetails object
 https://stripe.com/docs/api#dispute_object-evidence_details
 */

public protocol DisputeEvidenceDetails {
    var dueBy: Date? { get }
    var hasEvidence: Bool? { get }
    var pastDue: Bool? { get }
    var submissionCount: Int? { get }
}

public struct StripeDisputeEvidenceDetails: DisputeEvidenceDetails, StripeModel {
    public var dueBy: Date?
    public var hasEvidence: Bool?
    public var pastDue: Bool?
    public var submissionCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case dueBy = "due_by"
        case hasEvidence = "has_evidence"
        case pastDue = "past_due"
        case submissionCount = "submission_count"
    }
}
