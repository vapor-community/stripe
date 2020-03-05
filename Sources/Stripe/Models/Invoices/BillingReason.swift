//
//  BillingReason.swift
//  Stripe
//
//  Created by Nicolas Bachschmidt on 2018-11-23.
//

import Foundation

// https://stripe.com/docs/api/invoices/object?lang=curl#invoice_object-billing_reason
public enum StripeBillingReason: String, Codable {
    case subscriptionCreate = "subscription_create"
    case subscriptionUpdate = "subscription_update"
    case subscriptionCycle = "subscription_cycle"
    case subscription = "subscription"
    case manual
    case upcoming
}
