//
//  ExternalAccounts.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

/**
 External accounts list
 https://stripe.com/docs/api/curl#account_object-external_accounts
 */

public struct ExternalAccountsList: StripeModel {
    public var object: String?
    public var hasMore: Bool?
    public var totalCount: Int?
    public var url: String?
    private var data: String?
    public var cardAccounts: [StripeCard]?
    public var bankAccounts: [StripeBankAccount]?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        object = try container.decodeIfPresent(String.self, forKey: .object)
        hasMore = try container.decodeIfPresent(Bool.self, forKey: .hasMore)
        totalCount = try container.decodeIfPresent(Int.self, forKey: .totalCount)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        cardAccounts = try container.decodeIfPresent([StripeCard].self, forKey: .data)?.filter{ $0.object == "card" }
        bankAccounts = try container.decodeIfPresent([StripeBankAccount].self, forKey: .data)?.filter{ $0.object == "bank_account" }
    }
}

public protocol ExternalAccount {}
