//
//  Mandate.swift
//  Stripe
//
//  Created by Andrew Edwards on 1/26/18.
//

/**
 Mandate
 https://stripe.com/docs/api/curl#create_source-mandate
 */

public struct StripeMandate: StripeModel {
    public var acceptance: StripeTOSAcceptance?
    public var notificationMethod: String?
    
    public enum CodingKeys: String, CodingKey {
        case acceptance
        case notificationMethod = "notification_method"
    }
}
