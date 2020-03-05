//
//  OrderItem.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

/**
 OrderItem object
 https://stripe.com/docs/api#order_item_object-object
 */

public struct StripeOrderItem: StripeModel {
    public var object: String
    public var amount: Int
    public var currency: StripeCurrency?
    public var description: String?
    public var parent: String?
    public var quantity: Int?
    public var type: OrderItemType?
}
