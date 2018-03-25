//
//  DisputeReason.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/11/17.
//
//

// https://stripe.com/docs/api#dispute_object-reason
public enum DisputeReason: String, Codable {
    case duplicate
    case fraudulent
    case subscriptionCanceled = "subscription_canceled"
    case productUnacceptable = "product_unacceptable"
    case productNotReceived = "product_not_received"
    case unrecognized
    case creditNotProcessed = "credit_not_processed"
    case general
    case incorrectAccountDetails = "incorrect_account_details"
    case insufficientFunds = "insufficient_funds"
    case bankCannotProcess = "bank_cannot_process"
    case debitNotAuthorized = "debit_not_authorized"
    case customerInitiated = "customer_initiated"
}

// https://stripe.com/docs/api#dispute_object-status
public enum DisputeStatus: String, Codable {
    case warningNeedsResponse = "warning_needs_response"
    case warningUnderReview = "warning_under_review"
    case warningClosed = "warning_closed"
    case needsResponse = "needs_response"
    case underReview = "under_review"
    case chargeRefunded = "charge_refunded"
    case won
    case lost
}
