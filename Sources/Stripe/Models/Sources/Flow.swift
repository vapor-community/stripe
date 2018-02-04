//
//  Flow.swift
//  Stripe
//
//  Created by Andrew Edwards on 1/26/18.
//

/**
 Flow
 https://stripe.com/docs/api/curl#source_object-flow
 */

public enum Flow: String, Codable {
    case redirect
    case receiver
    case codeVerification = "code_verification"
    case none
}
