//
//  StatusTransitions.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation

/**
 StatusTransitions
 https://stripe.com/docs/api/curl#order_object-status_transitions
 */

public struct StripeOrderStatusTransitions: StripeModel {
    public var canceled: Date?
    public var fulfiled: Date?
    public var paid: Date?
    public var returned: Date?
}
