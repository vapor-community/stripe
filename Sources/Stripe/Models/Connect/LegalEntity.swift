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
    var dob: [String: Int]? { get }
    var firstName: String? { get }
    var lastName: String? { get }
    var gender: String? { get }
    var maidenName: String? { get }
    var personalAddress: A? { get }
    var phoneNumber: String? { get }
    var personalIdNumberProvided: Bool? { get }
    var ssnLast4Provided: Bool? { get }
    var taxIdRegistrar: String? { get }
    var type: String? { get }
    var verification: LEA? { get }
}

public struct StripeConnectAccountLegalEntity: LegalEntity, StripeModel {
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
}
