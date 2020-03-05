//
//  OrderReturn.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation

/**
 OrderReturn object
 https://stripe.com/docs/api#order_return_object
 */

public struct StripeOrderReturn: StripeModel {
    public var id: String
    public var object: String
    public var amount: Int?
    public var created: Date?
    public var currency: StripeCurrency?
    public var items: [StripeOrderItem]?
    public var livemode: Bool?
    public var order: String?
    public var refund: String?
}
