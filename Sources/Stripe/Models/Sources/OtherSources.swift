//
//  OtherSources.swift
//  Stripe
//
//  Created by Andrew Edwards on 12/6/17.
//

/**
 Payment Sources
 https://stripe.com/docs/sources
 */

// MARK: - ThreeDSecure
public struct ThreeDSecure: StripeModel {
    public var card: String?
    public var customer: String?
    public var authenticated: Bool?
}

// MARK: - Giropay
public struct Giropay: StripeModel {
    public var bankCode: String?
    public var bic: String?
    public var bankName: String?
    public var statementDescriptor: String?
}

// MARK: - SepaDebit
public struct SepaDebit: StripeModel {
    public var bankCode: String?
    public var country: String?
    public var fingerprint: String?
    public var last4: String?
    public var mandateReference: String?
    public var mandateUrl: String?
}

// MARK: - iDEAL
public struct iDEAL: StripeModel {
    public var bank: String?
    public var bic: String?
    public var ibanLast4: String?
    public var statementDescriptor: String?
}

// MARK: - SOFORT
public struct SOFORT: StripeModel {
    public var country: String?
    public var bankCode: String?
    public var bic: String?
    public var bankName: String?
    public var ibanLast4: String?
    public var preferredLanguage: String?
    public var statementDescriptor: String?
}

// MARK: - Bancontact
public struct Bancontact: StripeModel {
    public var bankCode: String?
    public var bic: String?
    public var bankName: String?
    public var statementDescriptor: String?
    public var preferredLanguage: String?
}

// MARK: - Alipay
public struct Alipay: StripeModel {
    public var nativeUrl: String?
    public var statementDescriptor: String?
}

// MARK: - P24
public struct P24: StripeModel {
    public var reference: String?
}
