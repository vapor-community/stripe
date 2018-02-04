//
//  RefundReason.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/13/17.
//
//

/**
 Refund reason
 https://stripe.com/docs/api/curl#refund_object-reason
 */

public enum RefundReason: String, Codable {
    case duplicate
    case fraudulent
    case requestedByCustomer = "requested_by_customer"
}
