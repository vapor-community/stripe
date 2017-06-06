//
//  RefundReason.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/13/17.
//
//

import Foundation

public enum RefundReason: String {
    case duplicate = "duplicate"
    case fraudulent = "fraudulent"
    case requestedByCustomer = "requested_by_customer"
}
