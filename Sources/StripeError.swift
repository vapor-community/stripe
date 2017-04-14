//
//  StripeError.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Foundation

enum StripeError: Error {
    
    // Provider Errors
    case missingConfig
    case missingAPIKey
    
    // API Error's
    case apiConnectionError
    case apiError
    case authenticationError
    case cardError
    case invalidRequestError
    case rate_LimitError
    case validationError
    
    
}
