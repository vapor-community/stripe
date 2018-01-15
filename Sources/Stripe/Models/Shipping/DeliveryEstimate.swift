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

public protocol DeliveryEstimate {
    var date: String? { get }
    var earliest: String? { get }
    var latest: String? { get }
    var type: DeliveryEstimateType? { get }
}

public struct StripeDeliveryEstimate: DeliveryEstimate, StripeModelProtocol {
    public var date: String?
    public var earliest: String?
    public var latest: String?
    public var type: DeliveryEstimateType?
}
