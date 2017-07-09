//
//  StripeDuration.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/28/17.
//
//

public enum StripeDuration: String {
    case forever = "forever"
    case once = "once"
    case repeating = "repeating"
    case never = "never"
    
    var description: String {
        return self.rawValue.uppercased()
    }
}

public enum StripePayoutInterval: String {
    case manual = "manual"
    case daily = "daily"
    case weekly = "weekly"
    case monthly = "monthly"
}

public enum StripeWeeklyAnchor: String {
    case sunday = "sunday"
    case monday = "monday"
    case tuesday = "tuesday"
    case wednesday = "wednesday"
    case thursday = "thursday"
    case friday = "friday"
    case saturday = "saturday"
}
