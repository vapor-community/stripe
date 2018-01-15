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
    var dateOfBirth: [String: Int]? { get }
    var address: SA? { get }
    var verification: LEV? { get }
}

public struct StripeLegalEntityAdditionalOwner: LegalEntityAdditionalOwner, StripeModelProtocol {
    public var firstName: String?
    public var lastName: String?
    public var dateOfBirth: [String: Int]?
    public var address: StripeAddress?
    public var verification: StripeLegalEntityVerification?
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case dateOfBirth = "dob"
        case address
        case verification
    }
}
