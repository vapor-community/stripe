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

public struct StripeLegalEntityAdditionalOwner: StripeModel {
    public var firstName: String?
    public var lastName: String?
    public var dob: [String: Int]?
    public var maidenName: String?
    public var personalIdNumberProvided: Bool?
    public var address: StripeAddress?
    public var verification: StripeLegalEntityVerification?
    
    public enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
        case dob
        case maidenName = "maiden_name"
        case personalIdNumberProvided = "personal_id_number_provided"
        case address
        case verification
    }
}
