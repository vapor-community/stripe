//
//  ExternalCardAccount.swift
//  Stripe
//
//  Created by Andrew Edwards on 1/20/18.
//

import Foundation

public struct StripeExternalCardAccount: ExternalAccount, StripeModel {
    public var object: String = "card"
    public var currency: StripeCurrency?
    public var defaultForCurrency: Bool?
    public var expirationMonth: Int?
    public var expirationYear: Int?
    public var number: String?
    public var addressCity: String?
    public var addressCountry: String?
    public var addressLine1: String?
    public var addressLine2: String?
    public var addressState: String?
    public var addressZip: String?
    public var cvc: String?
    public var metadata: [String: String]?
    public var name: String?
    
    enum CodingKeys: String, CodingKey {
        case object
        case currency
        case defaultForCurrency = "default_for_currency"
        case expirationMonth = "exp_month"
        case expirationYear = "exp_year"
        case number
        case addressCity = "address_city"
        case addressCountry = "address_country"
        case addressLine1 = "address_line1"
        case addressLine2 = "address_line2"
        case addressState = "address_state"
        case addressZip = "address_zip"
        case cvc
        case metadata
        case name
    }
}
