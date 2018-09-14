//
//  Card.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

/**
 Card object
 https://stripe.com/docs/api/curl#card_object
 https://stripe.com/docs/sources/cards
 */

public struct StripeCard: StripeModel {
    public var id: String
    public var object: String
    public var account: String?
    public var addressCity: String?
    public var addressCountry: String?
    public var addressLine1: String?
    public var addressLine1Check: CardValidationCheck?
    public var addressLine2: String?
    public var addressState: String?
    public var addressZip: String?
    public var addressZipCheck: CardValidationCheck?
    public var availablePayoutMethods: [String]?
    public var brand: String?
    public var country: String?
    public var currency: StripeCurrency?
    public var customer: String?
    public var cvcCheck: CardValidationCheck?
    public var defaultForCurrency: Bool?
    public var dynamicLast4: String?
    public var expMonth: Int?
    public var expYear: Int?
    public var fingerprint: String
    public var funding: FundingType?
    public var last4: String?
    public var metadata: [String: String]
    public var name: String?
    public var recipient: String?
    public var tokenizationMethod: TokenizedMethod?
    public var threeDSecure: String?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case account
        case addressCity = "address_city"
        case addressCountry = "address_country"
        case addressLine1 = "address_line1"
        case addressLine1Check = "address_line1_check"
        case addressLine2 = "address_line2"
        case addressState = "address_state"
        case addressZip = "address_zip"
        case addressZipCheck = "address_zip_check"
        case availablePayoutMethods = "available_payout_methods"
        case brand
        case country
        case customer
        case cvcCheck = "cvc_check"
        case defaultForCurrency = "default_for_currency"
        case dynamicLast4 = "dynamic_last4"
        case expMonth = "exp_month"
        case expYear = "exp_year"
        case fingerprint
        case funding
        case last4
        case metadata
        case name
        case recipient
        case tokenizationMethod = "tokenization_method"
        case threeDSecure = "three_d_secure"
    }
}
