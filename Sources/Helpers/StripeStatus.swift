//
//  StripeStatus.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

public enum StripeStatus: String {
    case success = "success"
    case succeeded = "succeeded"
    case failed = "failed"
    case pending = "pending"
    case canceled = "canceled"
    case chargeable = "chargeable"
}

public enum StripeSubscriptionStatus: String {
    case trailing = "trailing"
    case active = "active"
    case pastdue = "past_due"
    case canceled = "canceled"
    case unpaid = "unpaid"
}
