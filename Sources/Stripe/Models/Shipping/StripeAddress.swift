//
//  StripeAddress.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

/**
 Shipping Address
 https://stripe.com/docs/api/curl#order_object-shipping-address
 */

public struct StripeAddress: StripeModel {
    public var city: String?
    public var country: String?
    public var line1: String?
    public var line2: String?
    public var postalCode: String?
    public var state: String?
    
    public enum CodingKeys: String, CodingKey {
        case city
        case country
        case line1
        case line2
        case postalCode = "postal_code"
        case state
    }
}
