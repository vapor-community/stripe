//
//  StripeError.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

public enum StripeError: Error {

    // Provider Errors
    case missingConfig
    case missingAPIKey

    // Serialization
    case serializationIssue

    // API Error's
    case apiConnectionError
    case apiError
    case authenticationError
    case cardError
    case invalidRequestError(String?, String?)
    case rateLimitError
    case validationError

    // Other
    case invalidSourceType
}
