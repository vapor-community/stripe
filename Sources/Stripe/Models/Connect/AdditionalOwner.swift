//
//  AdditionalOwner.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

/**
 Additional Owner object
 https://stripe.com/docs/api/curl#account_object-legal_entity-additional_owners
 */

public protocol LegalEntityAdditionalOwner {
    associatedtype SA: Address
    associatedtype LEV: LegalEntityVerification
    
    var firstName: String? { get }
    var lastName: String? { get }
    var dob: [String: Int]? { get }
    var maidenName: String? { get }
    var personalIdNumberProvided: Bool? { get }
    var address: SA? { get }
    var verification: LEV? { get }
}

public struct StripeLegalEntityAdditionalOwner: LegalEntityAdditionalOwner, StripeModel {
    public var firstName: String?
    public var lastName: String?
    public var dob: [String: Int]?
    public var maidenName: String?
    public var personalIdNumberProvided: Bool?
    public var address: StripeAddress?
    public var verification: StripeLegalEntityVerification?
}
