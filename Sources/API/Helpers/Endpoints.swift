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

internal let DefaultHeaders = [
    HeaderKey.contentType: "application/x-www-form-urlencoded",
    StripeHeader.Version: "2017-04-06"
]

internal struct StripeHeader {
    static let Version = HeaderKey("Stripe-Version")
    static let Authorization = HeaderKey("Authorization")
    static let Account = HeaderKey("Stripe-Account")
}

internal enum API {
    
    /**
     BALANCE
     This is an object representing your Stripe balance. You can retrieve it to see the balance 
     currently on your Stripe account. You can also retrieve a list of the balance history, which 
     contains a list of transactions that contributed to the balance 
     (e.g., charges, transfers, and so forth). The available and pending amounts for each currency 
     are broken down further by payment source types.
     */
    case balance
    case balanceHistory
    case balanceHistoryTransaction(String)
    
    /**
     Charges
     
     To charge a credit or a debit card, you create a charge object. You can retrieve and refund 
     individual charges as well as list all charges. Charges are identified by a unique random ID.
    */
    case charges
    case charge(String)
    
    var endpoint: String {
        switch self {
        case .balance: return APIBase + APIVersion + "balance"
        case .balanceHistory: return APIBase + APIVersion + "balance/history"
        case .balanceHistoryTransaction(let id): return APIBase + APIVersion + "balance/history/\(id)"
        
        case .charges: return APIBase + APIVersion + "charges"
        case .charge(let id): return APIBase + APIVersion + "charges/\(id)"
        }
    }
    
}
