//
//  Account.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation

/**
 Account object
 https://stripe.com/docs/api#account_object
 */

public struct StripeConnectAccount: StripeModel {
    public var id: String
    public var object: String
    public var businessProfile: StripeConnectAccountBusinessProfile?
    public var businessType: StripeConnectAccountBusinessType?
    public var capabilities: StripeConnectAccountCapablities?
    public var chargesEnabled: Bool?
    public var company: StripeConnectAccountCompany?
    public var country: String?
    public var created: Date?
    public var defaultCurrency: StripeCurrency?
    public var detailsSubmitted: Bool?
    public var email: String?
    public var externalAccounts: StripeExternalAccountsList?
    public var individual: StripePerson?
    public var metadata: [String: String]
    public var payoutsEnabled: Bool?
    public var requirements: StripeConnectAccountRequirmenets?
    public var settings: StripeConnectAccountSettings?
    public var tosAcceptance: StripeTOSAcceptance?
    public var type: StripeConnectAccountType?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case object
        case businessProfile = "business_profile"
        case businessType = "business_type"
        case capabilities
        case chargesEnabled = "charges_enabled"
        case company
        case country
        case created
        case defaultCurrency = "default_currency"
        case detailsSubmitted = "details_submitted"
        case email
        case externalAccounts = "external_accounts"
        case individual
        case metadata
        case payoutsEnabled = "payouts_enabled"
        case requirements
        case settings
        case tosAcceptance = "tos_acceptance"
        case type
    }
}

public struct StripeConnectAccountList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var url: String?
    public var data: [StripeConnectAccount]?
    
    private enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case url
        case data
    }
}

public struct StripeConnectAccountBusinessProfile: StripeModel {
    public var mcc: String?
    public var name: String?
    public var productDescription: String?
    public var supportAddress: StripeAddress?
    public var supportEmail: String?
    public var supportPhone: String?
    public var supportUrl: String?
    public var url: String?
    
    private enum CodingKeys: String, CodingKey {
        case mcc
        case name
        case productDescription = "product_description"
        case supportAddress = "support_address"
        case supportEmail = "support_email"
        case supportPhone = "support_phone"
        case supportUrl = "support_url"
        case url
    }
}

public struct StripeConnectAccountCapablities: StripeModel {
    public var cardPayments: StripeConnectAccountCapabilitiesStatus?
    public var legacyPayments: StripeConnectAccountCapabilitiesStatus?
    public var platformPayments: StripeConnectAccountCapabilitiesStatus?
    
    private enum CodingKeys: String, CodingKey {
        case cardPayments = "card_payments"
        case legacyPayments = "legacy_payments"
        case platformPayments = "platform_payments"
    }
}

public struct StripeConnectAccountCompany: StripeModel {
    public var address: StripeAddress?
    public var directorsProvided: Bool?
    public var name: String?
    public var ownersProvided: Bool?
    public var phone: String?
    public var taxIdProvided: Bool?
    public var taxIdRegistrar: String?
    public var vatIdProvided: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case address
        case directorsProvided = "directors_provided"
        case name
        case ownersProvided = "owners_provided"
        case phone
        case taxIdProvided = "tax_id_provided"
        case taxIdRegistrar = "tax_id_registrar"
        case vatIdProvided = "vat_id_provided"
    }
}

public struct StripeConnectAccountRequirmenets: StripeModel {
    public var currentDeadline: Date?
    public var currentlyDue: [String]?
    public var disabledReason: String?
    public var eventuallyDue: [String]?
    public var pastDue: [String]?
    
    private enum CodingKeys: String, CodingKey {
        case currentDeadline = "current_deadline"
        case currentlyDue = "currently_due"
        case disabledReason = "disabled_reason"
        case eventuallyDue = "eventually_due"
        case pastDue = "past_due"
    }
}

public struct StripeConnectAccountSettings: StripeModel {
    public var branding: StripeConnectAccountSettingsBranding?
    public var cardPayments: StripeConnectAccountSettingsCardPayments?
    public var dashboard: StripeConnectAccountSettingsDashboard?
    public var payments: StripeConnectAccountSettingsPayments?
    public var payouts: StripeConnectAccountSettingsPayouts?
    
    private enum CodingKeys: String, CodingKey {
        case branding
        case cardPayments = "card_payments"
        case dashboard
        case payments
        case payouts
    }
}

public struct StripeConnectAccountSettingsBranding: StripeModel {
    public var icon: String?
    public var logo: String?
    public var primaryColor: String?
    
    private enum CodingKeys: String, CodingKey {
        case icon
        case logo
        case primaryColor = "primary_color"
    }
}

public struct StripeConnectAccountSettingsCardPayments: StripeModel {
    public var declineOn: StripeConnectAccountSettingsCardPaymentsDeclineOn?
    public var statementDescriptorPrefix: String?
    
    private enum CodingKeys: String, CodingKey {
        case declineOn = "decline_on"
        case statementDescriptorPrefix = "statement_descriptor_prefix"
    }
}

public struct StripeConnectAccountSettingsCardPaymentsDeclineOn: StripeModel {
    public var avsFailure: Bool?
    public var cvcFailure: Bool?
    
    private enum CodingKeys: String, CodingKey {
        case avsFailure = "avs_failure"
        case cvcFailure =  "cvc_failure"
    }
}

public struct StripeConnectAccountSettingsDashboard: StripeModel {
    public var displayName: String?
    public var timezone: String?
    
    private enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case timezone
    }
}

public struct StripeConnectAccountSettingsPayments: StripeModel {
    public var statementDescriptor: String?
    
    private enum CodingKeys: String, CodingKey {
        case statementDescriptor = "statement_descriptor"
    }
}

public struct StripeConnectAccountSettingsPayouts: StripeModel {
    public var debitNegativeBalances: Bool?
    public var schedule: StripePayoutSchedule?
    public var statementDescriptor: String?
    
    private enum CodingKeys: String, CodingKey {
        case debitNegativeBalances = "debit_negative_balances"
        case schedule
        case statementDescriptor = "statement_descriptor"
    }
}
