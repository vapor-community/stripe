//
//  ShippingLabel.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

/**
 Shipping
 https://stripe.com/docs/api/curl#charge_object-shipping
 */

public protocol Shipping {
    associatedtype T: Address
    var address: T? { get }
    var carrier: String? { get }
    var name: String? { get }
    var phone: String? { get }
    var trackingNumber: String? { get }
}

public struct ShippingLabel: Shipping, StripeModel {
    public var address: StripeAddress?
    public var carrier: String?
    public var name: String?
    public var phone: String?
    public var trackingNumber: String?
    
    public enum CodingKeys: CodingKey, String {
        case address
        case carrier
        case name
        case phone
        case trackingNumber = "tracking_number"
    }
}
