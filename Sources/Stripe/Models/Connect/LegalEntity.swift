//
//  LegalEntity.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation

/**
 Legal Entity object
 https://stripe.com/docs/api/curl#account_object-legal_entity
 */

public struct StripeConnectAccountLegalEntity: StripeModel {
    public var additionalOwners: [StripeLegalEntityAdditionalOwner]?
    public var address: StripeAddress?
    public var businessName: String?
    public var businessTaxIdProvided: Bool?
    public var businessVATIdProvided: Bool?
    public var dob: [String: Int]?
    public var firstName: String?
    public var lastName: String?
    public var gender: String?
    public var maidenName: String?
    public var personalIdNumberProvided: Bool?
    public var personalAddress: StripeAddress?
    public var phoneNumber: String?
    public var ssnLast4Provided: Bool?
    public var taxIdRegistrar: String?
    public var type: String?
    public var verification: StripeLegalEntityVerification?
    
    public enum CodingKeys: CodingKey, String {
        case additionalOwners = "additional_owners"
        case address
        case businessName = "business_name"
        case businessTaxIdProvided = "business_tax_id_provided"
        case businessVATIdProvided = "business_vat_id_provided"
        case dob
        case firstName = "first_name"
        case lastName = "last_name"
        case gender
        case maidenName = "maiden_name"
        case personalIdNumberProvided = "personal_id_number_provided"
        case personalAddress = "personal_address"
        case phoneNumber = "phone_number"
        case ssnLast4Provided = "ssn_last_4_provided"
        case taxIdRegistrar = "tax_id_registrar"
        case type
        case verification
    }
}
