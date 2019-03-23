//
//  CountrySpec.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/23/19.
//

import Vapor
/// Stripe needs to collect certain pieces of information about each account created. These requirements can differ depending on the account's country. The Country Specs API makes these rules available to your integration.
public struct StripeCountrySpec: StripeModel {
    /// Unique identifier for the object. Represented as the ISO country code for this country.
    public var id: String
    /// String representing the object’s type. Objects of the same type share the same value.
    public var object: String
    /// The default currency for this country. This applies to both payment methods and bank accounts.
    public var defaultCurrency: StripeCurrency?
    /// Currencies that can be accepted in the specific country (for transfers).
    public var supportedBankAccountCurrencies: [String: [String]]?
    /// Currencies that can be accepted in the specified country (for payments).
    public var supportedPaymentCurrencies: [StripeCurrency]?
    /// Payment methods available in the specified country. You may need to enable some payment methods (e.g., [ACH](https://stripe.com/docs/ach)) on your account before they appear in this list. The `stripe` payment method refers to [charging through your platform](https://stripe.com/docs/connect/destination-charges).
    public var supportedPaymentMethods: [String]?
    /// Countries that can accept transfers from the specified country.
    public var supportedTransferCountries: [String]?
    /// Lists the types of verification data needed to keep an account open.
    public var verificationFields: StripeCountrySpecVerificationFields?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case object
        case defaultCurrency = "default_currency"
        case supportedBankAccountCurrencies = "supported_bank_account_currencies"
        case supportedPaymentCurrencies = "supported_payment_currencies"
        case supportedPaymentMethods = "supported_payment_methods"
        case supportedTransferCountries = "supported_transfer_countries"
        case verificationFields = "verification_fields"
    }
}

public struct StripeCountrySpecList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeCountrySpec]?
    
    private enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case url
        case data
    }
}

public struct StripeCountrySpecVerificationFields: StripeModel {
    /// Verification types for company account.
    public var company: StripeCountrySpecVerificationFieldsAttributes?
    /// Verification types for individual account.
    public var individual: StripeCountrySpecVerificationFieldsAttributes?
}

public struct StripeCountrySpecVerificationFieldsAttributes: StripeModel {
    /// Additional fields which are only required for some users.
    public var additional: [String]?
    /// Fields which every account must eventually provide.
    public var minimum: [String]?
}
