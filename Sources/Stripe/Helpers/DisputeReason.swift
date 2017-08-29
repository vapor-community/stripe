//
//  DisputeReason.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/11/17.
//
//

import Foundation

public enum DisputeReason: String {
    case duplicate = "duplicate"
    case fraudulent = "fraudulent"
    case subscriptionCanceled = "subscription_canceled"
    case productUnacceptable = "product_unacceptable"
    case productNotReceived = "product_not_received"
    case unrecognized = "unrecognized"
    case creditNotProcessed = "credit_not_processed"
    case general = "general"
    case incorrectAccountDetails = "incorrect_account_details"
    case insufficientFunds = "insufficient_funds"
    case bankCannotProcess = "bank_cannot_process"
    case debitNotAuthorized = "debit_not_authorized"
    case customerInitiated = "customer_initiated"
}

public enum DisputeStatus: String {
    case warningNeedsResponse = "warning_needs_response"
    case warningUnderReview = "warning_under_review"
    case warningClosed = "warning_closed"
    case needsResponse = "needs_response"
    case underReview = "under_review"
    case chargeRefunded = "charge_refunded"
    case won = "won"
    case lost = "lost"
}
