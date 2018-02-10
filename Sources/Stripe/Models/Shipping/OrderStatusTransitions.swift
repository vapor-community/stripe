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

public protocol OrderStatusTransitions {
    var canceled: Date? { get }
    var fulfiled: Date? { get }
    var paid: Date? { get }
    var returned: Date? { get }
}

public struct StripeOrderStatusTransitions: OrderStatusTransitions, StripeModel {
    public var canceled: Date?
    public var fulfiled: Date?
    public var paid: Date?
    public var returned: Date?
}
