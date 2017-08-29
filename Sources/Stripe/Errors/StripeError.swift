//
//  StripeError.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Node

public enum StripeError: Error {

    // Provider Errors
    case missingConfig
    case missingAPIKey

    // Serialization
    case serializationError

    // API Error's
    case apiConnectionError(String)
    case apiError(String)
    case authenticationError(String)
    case cardError(String)
    case invalidRequestError(String)
    case rateLimitError(String)
    case validationError(String)

    // Other
    case invalidSourceType
    case missingParamater(String)
    
    public var localizedDescription: String {
        
        switch self {
        case .apiConnectionError(let err):
            return err
        case .apiError(let err):
            return err
        case .authenticationError(let err):
            return err
        case .cardError(let err):
            return err
        case .invalidRequestError(let err):
            return err
        case .rateLimitError(let err):
            return err
        case .validationError(let err):
            return err
        default:
            return "unknown error"
        }
    }
}
