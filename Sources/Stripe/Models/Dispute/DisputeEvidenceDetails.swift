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

public struct StripeDisputeEvidenceDetails: StripeModel {
    public var dueBy: Date?
    public var hasEvidence: Bool?
    public var pastDue: Bool?
    public var submissionCount: Int?
    
    public enum CodingKeys: String, CodingKey {
        case dueBy = "due_by"
        case hasEvidence = "has_evidence"
        case pastDue = "past_due"
        case submissionCount = "submission_count"
    }
}
