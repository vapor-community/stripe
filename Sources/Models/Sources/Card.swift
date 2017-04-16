//
//  Card.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor
import Helpers

/*
 Card Model
 https://stripe.com/docs/api/curl#card_object
 */
public final class Card: StripeModelProtocol {
    
    public let id: String
    public let object: String
    public let addressCity: String?
    public let addressCountry: String?
    public let addressLine1: String?
    public let addressLine1Check: ValidationCheck?
    public let addressLine2: String?
    public let addressState: String?
    public let addressZip: String?
    public let addressZipCheck: ValidationCheck?
    public let country: String
    public let brand: String
    public let customerId: String?
    public let cvcCheck: ValidationCheck?
    public let dynamicLastFour: String?
    public let expirationMonth: Int
    public let expirationYear: Int
    public let fingerprint: String?
    public let fundingType: FundingType?
    public let lastFour: String
    public let name: String?
    public let tokenizedMethod: TokenizedMethod?
    public let metadata: [String : Any]?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.addressCity = try node.get("address_city")
        self.addressCountry = try node.get("address_country")
        self.addressLine1 = try node.get("address_line1")
        self.addressLine1Check = try ValidationCheck(rawValue: node.get("address_line1_check"))
        self.addressLine2 = try node.get("address_line2")
        self.addressState = try node.get("address_state")
        self.addressZip = try node.get("address_zip")
        self.addressZipCheck = try ValidationCheck(rawValue: node.get("address_zip_check"))
        self.country = try node.get("country")
        self.brand = try node.get("brand")
        self.customerId = try node.get("customer")
        self.cvcCheck = try ValidationCheck(rawValue: node.get("cvc_check"))
        self.dynamicLastFour = try node.get("dynamic_last4")
        self.expirationMonth = try node.get("exp_month")
        self.expirationYear = try node.get("exp_year")
        self.fingerprint = try node.get("fingerprint")
        self.fundingType = try FundingType(rawValue: node.get("funding"))
        self.lastFour = try node.get("last4")
        self.name = try node.get("name")
        self.tokenizedMethod = try TokenizedMethod(rawValue: node.get("tokenization_method"))
        self.metadata = try node.get("metadata")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "id": self.id,
            "object": self.object,
            "address_city": self.addressCity,
            "address_country": self.addressCountry,
            "address_line1": self.addressLine1,
            "address_line1_check": self.addressZipCheck?.rawValue,
            "address_line2": self.addressLine2,
            "address_state": self.addressState,
            "address_zip": self.addressZip,
            "address_zip_check": self.addressZipCheck?.rawValue,
            "country": self.country,
            "brand": self.brand,
            "customer": self.customerId,
            "cvc_check": self.cvcCheck?.rawValue,
            "dynamic_last4": self.dynamicLastFour,
            "exp_month": self.expirationMonth,
            "exp_year": self.expirationYear,
            "fingerprint": self.fingerprint,
            "funding": self.fundingType?.rawValue,
            "last4": self.lastFour,
            "name": self.name,
            "tokenization_method": self.tokenizedMethod?.rawValue,
            "metadata": self.metadata
        ]
        return try Node(node: object)
    }
    
}
