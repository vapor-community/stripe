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

public protocol ShippingMethod {
    associatedtype D: DeliveryEstimate
    
    var id: String? { get }
    var amount: Int? { get }
    var currency: StripeCurrency? { get }
    var deliveryEstimate: D? { get }
    var description: String? { get }
}

public struct StripeShippingMethod: ShippingMethod, StripeModel {
    public var id: String?
    public var amount: Int?
    public var currency: StripeCurrency?
    public var deliveryEstimate: StripeDeliveryEstimate?
    public var description: String?
}
