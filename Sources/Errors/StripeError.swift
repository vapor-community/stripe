//
//  StripeError.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Node

public enum StripeError: Error {

    public struct ErrorInfo: NodeInitializable {
        public let message: String
        
        public init(node: Node) throws {
            self.message = try node.get("message")
        }
    }
    
    // Provider Errors
    case missingConfig
    case missingAPIKey

    // Serialization
    case serializationError

    // API Error's
    case apiConnectionError
    case apiError
    case authenticationError
    case cardError
    case invalidRequestError(ErrorInfo?)
    case rateLimitError
    case validationError

    // Other
    case invalidSourceType
    case missingParamater(String)
}
