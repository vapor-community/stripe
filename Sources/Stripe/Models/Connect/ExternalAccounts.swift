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
    public var data: [[String: String]]?
    // TODO: Implements parsing of items into typed arrays.
    public var cardAccounts: [StripeCard] = []
    public var bankAccounts: [StripeBankAccount] = []
}

public protocol ExternalAccount {}
