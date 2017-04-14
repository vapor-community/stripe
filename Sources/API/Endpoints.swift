//
//  Endpoints.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Foundation
import HTTP

internal let APIBase = "https://api.stripe.com/"
internal let APIVersion = "v1/"

internal let DefaultHeaders = [HeaderKey("Stripe-Version"): "2017-04-06"]

internal enum API {
    
    case charges
    
    var endpoint: String {
        switch self {
        case .charges: return APIBase + APIVersion + "charges/"
        }
    }
    
}
