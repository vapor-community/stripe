//
//  InvoiceStatusTransitions.swift
//  Stripe
//
//  Created by Kristian Andersen on 08/10/2019.
//

import Foundation

public struct StripeInvoiceStatusTransitions: StripeModel {
    /// The time that the invoice draft was finalized.
    public var finalizedAt: Date?
    /// The time that the invoice was marked uncollectible.
    public var markedUncollectableAt: Date?
    /// The time that the invoice was paid.
    public var paidAt: Date?
    /// The time that the invoice was voided.
    public var voidedAt: Date?

    public enum CodingKeys: String, CodingKey {
        case finalizedAt = "finalized_at"
        case markedUncollectableAt = "marked_uncollectable_at"
        case paidAt = "paid_at"
        case voidedAt = "voided_at"
    }
}
