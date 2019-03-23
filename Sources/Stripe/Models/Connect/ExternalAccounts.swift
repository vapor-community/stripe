//
//  ExternalAccounts.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

/// External accounts list. [See here](https://stripe.com/docs/api/accounts/object#account_object-external_accounts)
public struct StripeExternalAccountsList: StripeModel {
    /// String representing the object’s type. Objects of the same type share the same value. Always has the value list.
    public var object: String
    /**
     Needs to be a string because the result can be an array of 2 possible types `StripeCard` and/or `StripeBankAccount`.
     We'll actually decode the array of accounts seperately based on type and filtered based on object. See the initializer.
     The `data` key is still needed in the `CodingKeys` and for decoding that property from the Stripe API, so we still have to declare it even though the type is unused.
     */
    private var data: String?
    /// True if this list has another page of items after this one that can be fetched.
    public var hasMore: Bool?
    /// The URL where this list can be accessed.
    public var url: String?
    /// An array of `StripeCard`s associated with the account.
    public var cardAccounts: [StripeCard]?
    /// /// An array of `StripeBankAccount`s associated with the account.
    public var bankAccounts: [StripeBankAccount]?
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        object = try container.decode(String.self, forKey: .object)
        hasMore = try container.decode(Bool.self, forKey: .hasMore)
        url = try container.decodeIfPresent(String.self, forKey: .url)
        
        cardAccounts = try container.decodeIfPresent([StripeCard].self, forKey: .data)?.filter{ $0.object == "card" }
        bankAccounts = try container.decodeIfPresent([StripeBankAccount].self, forKey: .data)?.filter{ $0.object == "bank_account" }
    }
    
    private enum CodingKeys: String, CodingKey {
        case object
        case data
        case hasMore = "has_more"
        case url
        case cardAccounts
        case bankAccounts
    }
}
