//
//  TOSAcceptance.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation

/**
 Terms of acceptance objecr
 https://stripe.com/docs/api/curl#account_object-tos_acceptance
 */

public protocol TOSAcceptance {
    var timestamp: Date? { get }
    var ip: String? { get }
    var status: String? { get }
    var userAgent: String? { get }
}

public struct StripeTOSAcceptance: TOSAcceptance, StripeModel {
    public var timestamp: Date?
    public var ip: String?
    public var status: String?
    public var userAgent: String?
}
