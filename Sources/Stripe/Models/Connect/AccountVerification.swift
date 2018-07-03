//
//  AccountVerification.swift
//  Stripe
//
//  Created by Andrew Edwards on 12/8/17.
//

import Foundation

/**
 Account verification
 https://stripe.com/docs/api/curl#account_object-verification
 */

public struct StripeAccountVerification: StripeModel {
    public var disabledReason: String?
    public var dueBy: Date?
    public var fieldsNeeded: [String]?
    
    public enum CodingKeys: String, CodingKey {
        case disabledReason = "disabled_reason"
        case dueBy = "due_by"
        case fieldsNeeded = "fields_needed"
    }
}
