//
//  DeliveryEstimate.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

/**
 Delivery Estimate
 https://stripe.com/docs/api/curl#order_object-shipping_methods-delivery_estimate
 */

public struct StripeDeliveryEstimate: StripeModel {
    public var date: String?
    public var earliest: String?
    public var latest: String?
    public var type: DeliveryEstimateType?
}
