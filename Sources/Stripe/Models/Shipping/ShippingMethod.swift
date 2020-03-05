//
//  ShippingMethod.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

/**
 Shipping Method
 https://stripe.com/docs/api/curl#order_object-shipping_methods
 */

public struct StripeShippingMethod: StripeModel {
    public var id: String
    public var amount: Int?
    public var currency: StripeCurrency?
    public var deliveryEstimate: StripeDeliveryEstimate?
    public var description: String?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case amount
        case currency
        case deliveryEstimate = "delivery_estimate"
        case description
    }
}
