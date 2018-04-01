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

public protocol Owner {
    associatedtype A: Address
    var address: A? { get }
    var email: String? { get }
    var name: String? { get }
    var phone: String? { get }
    var verifiedAddress: A? { get }
    var verifiedEmail: String? { get }
    var verifiedName: String? { get }
    var verifiedPhone: String? { get }
}

public struct StripeOwner: Owner, StripeModel {
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
