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
    var addressLine1: String? { get }
    var addressLine2: String? { get }
    var postalCode: String? { get }
    var state: String? { get }
}

public struct StripeAddress: Address, StripeModelProtocol {
    public var city: String?
    public var country: String?
    public var addressLine1: String?
    public var addressLine2: String?
    public var postalCode: String?
    public var state: String?
    
    enum CodingKeys: String, CodingKey {
        case city
        case country
        case addressLine1 = "line1"
        case addressLine2 = "line2"
        case postalCode = "postal_code"
        case state
    }
}
