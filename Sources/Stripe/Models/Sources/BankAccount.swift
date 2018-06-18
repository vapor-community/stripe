//
//  BankAccount.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/12/17.
//
//

/**
 Bank Account object
 https://stripe.com/docs/api/curl#customer_bank_account_object
*/

public struct StripeBankAccount: StripeModel {
    public var id: String
    public var object: String
    public var account: String?
    public var accountHolderName: String?
    public var accountHolderType: String?
    public var bankName: String?
    public var country: String
    public var currency: StripeCurrency?
    public var customer: String?
    public var defaultForCurrency: Bool?
    public var fingerprint: String
    public var last4: String
    public var metadata: [String: String]?
    public var routingNumber: String?
    public var status: BankAccountStatus?
    
    public enum CodingKeys: CodingKey, String {
        case id
        case object
        case account
        case accountHolderName = "account_holder_name"
        case accountHolderType = "account_holder_type"
        case bankName = "bank_name"
        case country
        case currency
        case customer
        case defaultForCurrency = "default_for_currency"
        case fingerprint
        case last4
        case metadata
        case routingNumber = "routing_number"
        case status
    }
}

public enum BankAccountStatus: String, Codable {
    case new
    case validated
    case verified
    case verificationFailed = "verification_failed"
    case errored
}
