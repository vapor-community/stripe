//
//  Card.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor


/**
 Card Model
 https://stripe.com/docs/api/curl#card_object
 */
public final class Card: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var account: String?
    public private(set) var addressLine1Check: ValidationCheck?
    public private(set) var addressZipCheck: ValidationCheck?
    public private(set) var country: String?
    public private(set) var brand: String?
    public private(set) var customerId: String?
    public private(set) var cvcCheck: ValidationCheck?
    public private(set) var dynamicLastFour: String?
    public private(set) var fingerprint: String?
    public private(set) var fundingType: FundingType?
    public private(set) var lastFour: String
    public private(set) var tokenizedMethod: TokenizedMethod?
    public private(set) var currency: StripeCurrency?
    public private(set) var defaultForCurrency: Bool?
    public private(set) var recipient: String?
    
    /**
     Only these values are mutable/updatable.
     https://stripe.com/docs/api/curl#update_card
     */
    
    public private(set) var addressCity: String?
    public private(set) var addressCountry: String?
    public private(set) var addressLine1: String?
    public private(set) var addressLine2: String?
    public private(set) var addressState: String?
    public private(set) var addressZip: String?
    public private(set) var expirationMonth: Int?
    public private(set) var expirationYear: Int?
    public private(set) var metadata: Node?
    public private(set) var name: String?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.account = try node.get("account")
        self.addressCity = try node.get("address_city")
        self.addressCountry = try node.get("address_country")
        self.addressLine1 = try node.get("address_line1")
        if let addressLine1Check = node["address_line1_check"]?.string {
            self.addressLine1Check = ValidationCheck(optionalRawValue: addressLine1Check)
        }
        self.addressLine2 = try node.get("address_line2")
        self.addressState = try node.get("address_state")
        self.addressZip = try node.get("address_zip")
        if let addressZipCheck = node["address_zip_check"]?.string {
            self.addressZipCheck = ValidationCheck(optionalRawValue: addressZipCheck)
        }
        self.country = try node.get("country")
        self.brand = try node.get("brand")
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        self.defaultForCurrency = try node.get("default_for_currency")
        self.customerId = try node.get("customer")
        if let cvcCheck = node["cvc_check"]?.string {
            self.cvcCheck = ValidationCheck(optionalRawValue: cvcCheck)
        }
        self.dynamicLastFour = try node.get("dynamic_last4")
        self.expirationMonth = try node.get("exp_month")
        self.expirationYear = try node.get("exp_year")
        self.fingerprint = try node.get("fingerprint")
        if let fundingType = node["funding"]?.string {
            self.fundingType = FundingType(optionalRawValue: fundingType)
        }
        self.lastFour = try node.get("last4")
        self.name = try node.get("name")
        if let tokenizedMethod = node["tokenization_method"]?.string {
            self.tokenizedMethod = TokenizedMethod(optionalRawValue: tokenizedMethod)
        }
        self.recipient = try node.get("recipient")
        
        self.metadata = try node.get("metadata")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "id": self.id,
            "object": self.object,
            "account": self.account,
            "address_city": self.addressCity,
            "address_country": self.addressCountry,
            "address_line1": self.addressLine1,
            "address_line1_check": self.addressLine1Check?.rawValue,
            "address_line2": self.addressLine2,
            "address_state": self.addressState,
            "address_zip": self.addressZip,
            "address_zip_check": self.addressZipCheck?.rawValue,
            "country": self.country,
            "brand": self.brand,
            "customer": self.customerId,
            "currency": self.currency?.rawValue,
            "cvc_check": self.cvcCheck?.rawValue,
            "default_for_currency": self.defaultForCurrency,
            "dynamic_last4": self.dynamicLastFour,
            "exp_month": self.expirationMonth,
            "exp_year": self.expirationYear,
            "fingerprint": self.fingerprint,
            "funding": self.fundingType?.rawValue,
            "last4": self.lastFour,
            "name": self.name,
            "recipient": self.recipient,
            "tokenization_method": self.tokenizedMethod?.rawValue,
            "metadata": self.metadata
        ]
        return try Node(node: object)
    }
}
