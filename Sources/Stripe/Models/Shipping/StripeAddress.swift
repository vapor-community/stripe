//
//  StripeAddress.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

/**
 Shipping Address
 https://stripe.com/docs/api/curl#charge_object-shipping-address
 */

public protocol Address {
    var city: String? { get }
    var country: String? { get }
    var line1: String? { get }
    var line2: String? { get }
    var postalCode: String? { get }
    var state: String? { get }
}

public struct StripeAddress: Address, StripeModel {
    public var city: String?
    public var country: String?
    public var line1: String?
    public var line2: String?
    public var postalCode: String?
    public var state: String?
}
