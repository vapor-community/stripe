//
//  TOSAcceptance.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation

/**
 Terms of acceptance object
 https://stripe.com/docs/api/curl#account_object-tos_acceptance
 */

public struct StripeTOSAcceptance: StripeModel {
    public var date: Date?
    public var ip: String?
    public var userAgent: String?
    
    public enum CodingKeys: String, CodingKey {
        case date
        case ip
        case userAgent = "user_agent"
    }
}
