//
//  Customer.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/19/17.
//
//

import Foundation

/**
 Customer Model
 https://stripe.com/docs/api/curl#customer_object
 */

public struct StripeCustomer: StripeModel {
    public var id: String
    public var object: String
    public var accountBalance: Int?
    public var created: Date?
    public var currency: StripeCurrency?
    public var defaultSource: String?
    public var delinquent: Bool?
    public var description: String?
    public var discount: StripeDiscount?
    public var email: String?
    public var invoicePrefix: String?
    public var invoiceSettings: StripeInvoiceSettings?
    public var livemode: Bool?
    public var metadata: [String: String]
    public var shipping: ShippingLabel?
    public var sources: StripeSourcesList?
    public var subscriptions: StripeSubscriptionsList?
    public var taxInfo: StripeCustomerTaxInfo?
    public var taxInfoVerification: StripeCustomerTaxInfo?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case accountBalance = "account_balance"
        case created
        case currency
        case defaultSource = "default_source"
        case delinquent
        case description
        case discount
        case email
        case invoicePrefix = "invoice_prefix"
        case invoiceSettings = "invoice_settings"
        case livemode
        case metadata
        case shipping
        case sources
        case subscriptions
        case taxInfo = "tax_info"
        case taxInfoVerification = "tax_info_verification"
    }
}

public struct StripeCustomerTaxInfo: StripeModel {
    public var taxId: String?
    public var type: String?
    
    private enum CodingKeys: String, CodingKey {
        case taxId = "tax_id"
        case type
    }
}

public struct StripeCustomerTaxInfoVerification: StripeModel {
    public var status: String?
    public var verifiedName: String?
    
    private enum CodingKeys: String, CodingKey {
        case status
        case verifiedName = "verified_name"
    }
}

public struct StripeInvoiceSettings: StripeModel {
    public var footer: String?
    public var customFields: [StripeInvoiceCustomFields]?
    
    private enum CodingKeys: String, CodingKey {
        case footer
        case customFields = "custom_fields"
    }
}

public struct StripeInvoiceCustomFields: StripeModel {
    public var name: String?
    public var value: String?
}
