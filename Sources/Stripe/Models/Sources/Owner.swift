//
//  Owner.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

/**
 Owner object
 https://stripe.com/docs/api/curl#source_object-owner
 */

public struct StripeOwner: StripeModel {
    public var address: StripeAddress?
    public var email: String?
    public var name: String?
    public var phone: String?
    public var verifiedAddress: StripeAddress?
    public var verifiedEmail: String?
    public var verifiedName: String?
    public var verifiedPhone: String?
    
    public enum CodingKeys: String, CodingKey {
        case address
        case email
        case name
        case phone
        case verifiedAddress = "verified_address"
        case verifiedEmail = "verified_email"
        case verifiedName = "verified_name"
        case verifiedPhone = "verified_phone"
    }
}
