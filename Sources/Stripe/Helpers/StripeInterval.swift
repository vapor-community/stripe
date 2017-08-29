//
//  StripeInterval.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/17.
//
//

import Foundation

public enum StripeInterval: String {
    case day = "day"
    case week = "week"
    case month = "month"
    case year = "year"
    
    case never = "never"
    
    var description: String {
        return self.rawValue.uppercased()
    }
}
