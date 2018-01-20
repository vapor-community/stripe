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

public protocol AccountVerification {
    var disabledReason: String? { get }
    var dueBy: Date? { get }
    var fieldsNeeded: [String]? { get }
}

public struct StripeAccountVerification: AccountVerification, StripeModel {
    public var disabledReason: String?
    public var dueBy: Date?
    public var fieldsNeeded: [String]?
    
    enum CodingKeys: String, CodingKey {
        case disabledReason = "disabled_reason"
        case dueBy = "due_by"
        case fieldsNeeded = "fields_needed"
    }
}
