//
//  StripeDuration.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/28/17.
//
//

public enum StripeDuration: String, Codable {
    case forever
    case once
    case repeating
}

// https://stripe.com/docs/api/curl#account_object-payout_schedule-interval
public enum StripePayoutInterval: String, Codable {
    case manual
    case daily
    case weekly
    case monthly
}

// https://stripe.com/docs/api/curl#account_object-payout_schedule-weekly_anchor
public enum StripeWeeklyAnchor: String, Codable {
    case sunday
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
}
