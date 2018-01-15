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

public protocol LegalEntity {
    associatedtype AO: LegalEntityAdditionalOwner
    associatedtype A: Address
    associatedtype LEA: LegalEntityVerification
    
    var additionalOwners: [AO]?  { get }
    var address: A?  { get }
    var businessName: String?  { get }
    var businessTaxIdProvided: Bool?  { get }
    var businessVATIdProvided: Bool?  { get }
    var dateOfBirth: [String: Int]? { get }
    var firstName: String? { get }
    var lastName: String? { get }
    var gender: String? { get }
    var maidenName: String? { get }
    var personalAddress: A? { get }
    var phoneNumber: String? { get }
    var ssnLast4Provided: Bool? { get }
    var taxIdRegistrar: String? { get }
    var type: String? { get }
    var verification: LEA? { get }
}

public struct StripeConnectAccountLegalEntity: LegalEntity, StripeModelProtocol {
    public var additionalOwners: [StripeLegalEntityAdditionalOwner]?
    public var address: StripeAddress?
    public var businessName: String?
    public var businessTaxIdProvided: Bool?
    public var businessVATIdProvided: Bool?
    public var dateOfBirth: [String: Int]?
    public var firstName: String?
    public var lastName: String?
    public var gender: String?
    public var maidenName: String?
    public var personalAddress: StripeAddress?
    public var phoneNumber: String?
    public var ssnLast4Provided: Bool?
    public var taxIdRegistrar: String?
    public var type: String?
    public var verification: StripeLegalEntityVerification?
    
    enum CodingKeys: String, CodingKey {
        case additionalOwners = "additional_owners"
        case address
        case businessName = "business_name"
        case businessTaxIdProvided = "business_tax_id_provided"
        case businessVATIdProvided = "business_vat_id_provided"
        case dateOfBirth = "dob"
        case firstName = "first_name"
        case lastName = "last_name"
        case gender
        case maidenName = "maiden_name"
        case personalAddress = "personal_address"
        case phoneNumber = "phone_number"
        case ssnLast4Provided = "ssn_last_4_provided"
        case taxIdRegistrar = "tax_id_registrar"
        case type
        case verification
    }
}
