//
//  LegalEntity.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation
import Vapor
import Helpers

/**
 Legal Entity
 */

public final class LegalEntity: StripeModelProtocol {
    
    public private(set) var additionalOwners: [AdditionalOwner]?
    public private(set) var address: ShippingAddress?
    public private(set) var businessName: String?
    public private(set) var businessTaxIdProvided: Bool?
    public private(set) var businessVATIdProvided: Bool?
    public private(set) var dateOfBirth: Node?
    public private(set) var firstName: String?
    public private(set) var lastName: String?
    public private(set) var gender: String?
    public private(set) var maidenName: String?
    public private(set) var personalAddress: ShippingAddress?
    public private(set) var phoneNumber: String?
    public private(set) var ssnLast4Provided: Bool?
    public private(set) var taxIdRegistrar: String?
    public private(set) var type: String?
    public private(set) var verification: Verification?
    
    public init(node: Node) throws {
        self.additionalOwners = try node.get("additional_owners")
        self.address = try node.get("address")
        self.businessName = try node.get("business_name")
        self.businessTaxIdProvided = try node.get("business_tax_id_provided")
        self.businessVATIdProvided = try node.get("business_vat_id_provided")
        self.dateOfBirth = try node.get("dob")
        self.firstName = try node.get("first_name")
        self.lastName = try node.get("last_name")
        self.gender = try node.get("gender")
        self.maidenName = try node.get("maiden_name")
        self.personalAddress = try node.get("personal_address")
        self.phoneNumber = try node.get("phone_number")
        self.ssnLast4Provided = try node.get("ssn_last_4_provided")
        self.taxIdRegistrar = try node.get("tax_id_registrar")
        self.type = try node.get("type")
        self.verification = try node.get("verification")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "additional_owners": additionalOwners,
            "address": self.address,
            "business_name": self.businessName,
            "business_tax_id_provided": self.businessTaxIdProvided,
            "business_vat_id_provided": self.businessVATIdProvided,
            "dob": self.dateOfBirth,
            "first_name": self.firstName,
            "last_name": self.lastName,
            "gender": self.gender,
            "maiden_name": self.maidenName,
            "personal_address": self.personalAddress,
            "phone_number": self.phoneNumber,
            "ssn_last_4_provided": self.ssnLast4Provided,
            "tax_id_registrar": self.taxIdRegistrar,
            "type": self.type,
            "verification": self.verification
        ]
        
        return try Node(node: object)
    }
}
