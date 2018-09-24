//
//  ShippingLabel.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

/**
 Shipping
 https://stripe.com/docs/api/curl#order_object-shipping
 */

public struct ShippingLabel: StripeModel {
    public var address: StripeAddress?
    public var carrier: String?
    public var name: String?
    public var phone: String?
    public var trackingNumber: String?
    
    public init(address: StripeAddress? = nil,
                carrier: String? = nil,
                name: String? = nil,
                phone: String? = nil,
                trackingNumber: String? = nil) {
        self.address = address
        self.carrier = carrier
        self.name = name
        self.phone = phone
        self.trackingNumber = trackingNumber
    }
    
    public enum CodingKeys: String, CodingKey {
        case address
        case carrier
        case name
        case phone
        case trackingNumber = "tracking_number"
    }
}
