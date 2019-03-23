//
//  ExternalAccountsRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 3/23/19.
//

import Vapor

public protocol ExternalAccountsRoutes {
    /// Creates a new bank account. When you create a new bank account, you must specify a [Custom account](https://stripe.com/docs/connect/custom-accounts) to create it on.
    ///
    /// - Parameters:
    ///   - account: The connect account this bank account should be created for.
    ///   - bankAccount: Either a token, like the ones returned by [Stripe.js](https://stripe.com/docs/stripe-js/reference), or a dictionary containing a user’s bank account details
    ///   - defaultForCurrency: When set to true, or if this is the first external account added in this currency, this account becomes the default external account for its currency.

    ///   - metadata: A set of key-value pairs that you can attach to an external account object. It can be useful for storing additional information about the external account in a structured format.
    /// - Returns: A `StripeBankAccount`.
    /// - Throws: A `StripeError`.
    func create(account: String, bankAccount: Any, defaultForCurrency: Bool?, metadata: [String: String]?) throws -> EventLoopFuture<StripeBankAccount>
    
    /// By default, you can see the 10 most recent external accounts stored on a Custom account directly on the object, but you can also retrieve details about a specific bank account stored on the [Custom account](https://stripe.com/docs/connect/custom-accounts).
    ///
    /// - Parameters:
    ///   - account: The connect account associated with this bank account.
    ///   - id: The ID of the bank account to retrieve.
    /// - Returns: A `StripeBankAccount`.
    /// - Throws: A `StripeError`.
    func retrieve(account: String, id: String) throws -> EventLoopFuture<StripeBankAccount>
    
    /// Updates the metadata, account holder name, and account holder type of a bank account belonging to a [Custom account](https://stripe.com/docs/connect/custom-accounts), and optionally sets it as the default for its currency. Other bank account details are not editable by design. \n You can re-enable a disabled bank account by performing an update call without providing any arguments or changes.
    ///
    /// - Parameters:
    ///   - account: The connect account associated with this bank account.
    ///   - id: The ID of the bank account to update.
    ///   - accountHolderName: The name of the person or business that owns the bank account. This will be unset if you POST an empty value.
    ///   - accountHolderType: The type of entity that holds the account. This can be either `individual` or `company`. This will be unset if you POST an empty value.
    ///   - defaultForCurrency: When set to true, this becomes the default external account for its currency.
    ///   - metadata: A set of key-value pairs that you can attach to an external account object. It can be useful for storing additional information about the external account in a structured format.
    /// - Returns: A `StripeBankAccount`.
    /// - Throws: A `StripeError`.
    func update(account: String,
                id: String,
                accountHolderName: String?,
                accountHolderType: StripeBankAccountHolderType?,
                defaultForCurrency: Bool?,
                metadata: [String: String]?) throws -> EventLoopFuture<StripeBankAccount>
    
    /// Deletes a bank account. You can delete destination bank accounts from a [Custom account](https://stripe.com/docs/connect/custom-accounts). \n If a bank account's `default_for_currency` property is true, it can only be deleted if it is the only external account for that currency, and the currency is not the Stripe account's default currency. Otherwise, before deleting the account, you must set another external account to be the default for the currency.

    ///
    /// - Parameters:
    ///   - account: The connect account associated with this bank account.
    ///   - id: The ID of the bank account to be deleted.
    /// - Returns: A `StripeDeletedObject`.
    /// - Throws: A `StripeError`.
    func deleteBankAccount(account: String, id: String) throws -> EventLoopFuture<StripeDeletedObject>
    
    /// List all bank accounts belonging to a connect account. You can see a list of the bank accounts belonging to a [Custom account](https://stripe.com/docs/connect/custom-accounts). Note that the 10 most recent external accounts are always available by default on the corresponding Stripe object. If you need more than those 10, you can use this API method and the `limit` and `starting_after` parameters to page through additional bank accounts.
    ///
    /// - Parameters:
    ///   - account: The connect account associated with the bank account(s).
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/external_account_bank_accounts/list)
    /// - Returns: A `StripeBankAccountList`.
    /// - Throws: A `StripeError`.
    func listAll(account: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeBankAccountList>
    
    /// Creates a new card. When you create a new card, you must specify a [Custom account](https://stripe.com/docs/connect/custom-accounts) to create it on. \n If the account has no default destination card, then the new card will become the default. However, if the owner already has a default then it will not change. To change the default, you should set `default_for_currency` to `true` when creating a card for a Custom account.
    ///
    /// - Parameters:
    ///   - account: The connect account this card should be created for.
    ///   - card: Either a token, like the ones returned by [Stripe.js](https://stripe.com/docs/stripe-js/reference), or a dictionary containing a user’s card details.
    ///   - defaultForCurrency: When set to true, or if this is the first external account added in this currency, this account becomes the default external account for its currency.
    
    ///   - metadata: A set of key-value pairs that you can attach to an external account object. It can be useful for storing additional information about the external account in a structured format.
    /// - Returns: A `StripeCard`.
    /// - Throws: A `StripeError`.
    func create(account: String, card: Any, defaultForCurrency: Bool?, metadata: [String: String]?) throws -> EventLoopFuture<StripeCard>
    
    /// By default, you can see the 10 most recent external accounts stored on a [Custom account](https://stripe.com/docs/connect/custom-accounts) directly on the object, but you can also retrieve details about a specific card stored on the [Custom account](https://stripe.com/docs/connect/custom-accounts).
    ///
    /// - Parameters:
    ///   - account: The connect account associated with this card.
    ///   - id: The ID of the card to retrieve.
    /// - Returns: A `StripeCard`.
    /// - Throws: A `StripeError`.
    func retrieve(account: String, id: String) throws -> EventLoopFuture<StripeCard>
    
    /// If you need to update only some card details, like the billing address or expiration date, you can do so without having to re-enter the full card details. Stripe also works directly with card networks so that your customers can [continue using your service](https://stripe.com/docs/saving-cards#automatic-card-updates) without interruption.
    /// - Parameters:
    ///   - account: The connect account associated with this card.
    ///   - id: The ID of the card to update.
    ///   - addressCity: City/District/Suburb/Town/Village. This will be unset if you POST an empty value.
    ///   - addressCountry: Billing address country, if provided when creating card. This will be unset if you POST an empty value.
    ///   - addressLine1: Address line 1 (Street address/PO Box/Company name). This will be unset if you POST an empty value.
    ///   - addressLine2: Address line 2 (Apartment/Suite/Unit/Building). This will be unset if you POST an empty value.
    ///   - addressState: State/County/Province/Region. This will be unset if you POST an empty value.
    ///   - addressZip: ZIP or postal code. This will be unset if you POST an empty value.
    ///   - defaultForCurrency: When set to true, this becomes the default external account for its currency.
    ///   - expMonth: Two digit number representing the card’s expiration month.
    ///   - expYear: Four digit number representing the card’s expiration year.
    ///   - metadata: A set of key-value pairs that you can attach to an external account object. It can be useful for storing additional information about the external account in a structured format.
    ///   - name: Cardholder name. This will be unset if you POST an empty value.
    /// - Returns: A `StripeCard`.
    /// - Throws: A `StripeError`.
    func update(account: String,
                id: String,
                addressCity: String?,
                addressCountry: String?,
                addressLine1: String?,
                addressLine2: String?,
                addressState: String?,
                addressZip: String?,
                defaultForCurrency: Bool?,
                expMonth: Int?,
                expYear: Int?,
                metadata: [String: String]?,
                name: String?) throws -> EventLoopFuture<StripeCard>
    
    /// Deletes a card. If a card's default_for_currency property is true, it can only be deleted if it is the only external account for that currency, and the currency is not the Stripe account's default currency. Otherwise, before deleting the card, you must set another external account to be the default for the currency.
    ///
    /// - Parameters:
    ///   - account: The connect account associated with this card.
    ///   - id: The ID of the card to be deleted.
    /// - Returns: A `StripeDeletedObject`.
    /// - Throws: A `StripeError`.
    func deleteCard(account: String, id: String) throws -> EventLoopFuture<StripeDeletedObject>
    
    /// List all cards belonging to a connect account. You can see a list of the cards belonging to a [Custom account](https://stripe.com/docs/connect/custom-accounts). Note that the 10 most recent external accounts are always available by default on the corresponding Stripe object. If you need more than those 10, you can use this API method and the `limit` and `starting_after` parameters to page through additional bank accounts.
    ///
    /// - Parameters:
    ///   - account: The connect account associated with the card(s).
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/external_account_cards/list)
    /// - Returns: A `StripeCardList`.
    /// - Throws: A `StripeError`.
    func listAll(account: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeCardList>
}

extension ExternalAccountsRoutes {
    public func create(account: String, bankAccount: Any, defaultForCurrency: Bool? = nil, metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeBankAccount> {
        return try create(account: account, bankAccount: bankAccount, defaultForCurrency: defaultForCurrency, metadata: metadata)
    }
    
    public func retrieve(account: String, id: String) throws -> EventLoopFuture<StripeBankAccount> {
        return try retrieve(account: account, id: id)
    }
    
    public func update(account: String,
                       id: String,
                       accountHolderName: String? = nil,
                       accountHolderType: StripeBankAccountHolderType? = nil,
                       defaultForCurrency: Bool? = nil,
                       metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeBankAccount> {
        return try update(account: account,
                          id: id,
                          accountHolderName: accountHolderName,
                          accountHolderType: accountHolderType,
                          defaultForCurrency: defaultForCurrency,
                          metadata: metadata)
    }
    
    public func deleteBankAccount(account: String, id: String) throws -> EventLoopFuture<StripeDeletedObject> {
        return try deleteBankAccount(account: account, id: id)
    }
    
    public func listAll(account: String, filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeBankAccountList> {
        return try listAll(account: account, filter: filter)
    }
    
    public func create(account: String, card: Any, defaultForCurrency: Bool? = nil, metadata: [String: String]? = nil) throws -> EventLoopFuture<StripeCard> {
        return try create(account: account, card: card, defaultForCurrency: defaultForCurrency, metadata: metadata)
    }
    
    public func retrieve(account: String, id: String) throws -> EventLoopFuture<StripeCard> {
        return try retrieve(account: account, id: id)
    }
    
    public func update(account: String,
                       id: String,
                       addressCity: String? = nil,
                       addressCountry: String? = nil,
                       addressLine1: String? = nil,
                       addressLine2: String? = nil,
                       addressState: String? = nil,
                       addressZip: String? = nil,
                       defaultForCurrency: Bool? = nil,
                       expMonth: Int? = nil,
                       expYear: Int? = nil,
                       metadata: [String: String]? = nil,
                       name: String?) throws -> EventLoopFuture<StripeCard> {
        return try update(account: account,
                          id: id,
                          addressCity: addressCity,
                          addressCountry: addressCountry,
                          addressLine1: addressLine1,
                          addressLine2: addressLine2,
                          addressState: addressState,
                          addressZip: addressZip,
                          defaultForCurrency: defaultForCurrency,
                          expMonth: expMonth,
                          expYear: expYear,
                          metadata: metadata,
                          name: name)
    }
    
    public func deleteCard(account: String, id: String) throws -> EventLoopFuture<StripeDeletedObject> {
        return try deleteCard(account: account, id: id)
    }
    
    public func listAll(account: String, filter: [String: Any]? = nil) throws -> EventLoopFuture<StripeCardList> {
        return try listAll(account: account, filter: filter)
    }
}

public struct StripeExternalAccountsRoutes: ExternalAccountsRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    public func create(account: String, bankAccount: Any, defaultForCurrency: Bool?, metadata: [String: String]?) throws -> EventLoopFuture<StripeBankAccount> {
        var body: [String: Any] = [:]
        
        if let bankToken = bankAccount as? String {
            body["external_account"] = bankToken
        } else if let bankDetails = bankAccount as? [String: Any] {
            bankDetails.forEach { body["external_account[\($0)]"] = $1 }
        }
        
        if let defaultForCurrency = defaultForCurrency {
            body["default_for_currency"] = defaultForCurrency
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.externalAccount(account).endpoint, body: body.queryParameters)
    }
    
    public func retrieve(account: String, id: String) throws -> EventLoopFuture<StripeBankAccount> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.externalAccounts(account, id).endpoint)
    }
    
    public func update(account: String,
                       id: String,
                       accountHolderName: String?,
                       accountHolderType: StripeBankAccountHolderType?,
                       defaultForCurrency: Bool?,
                       metadata: [String: String]?) throws -> EventLoopFuture<StripeBankAccount> {
        var body: [String: Any] = [:]
        
        if let accountHolderName = accountHolderName {
            body["account_holder_name"] = accountHolderName
        }
        
        if let accountHolderType = accountHolderType {
            body["account_holder_type"] = accountHolderType.rawValue
        }
        
        if let defaultForCurrency = defaultForCurrency {
            body["default_for_currency"] = defaultForCurrency
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.externalAccounts(account, id).endpoint, body: body.queryParameters)
    }
    
    public func deleteBankAccount(account: String, id: String) throws -> EventLoopFuture<StripeDeletedObject> {
        return try request.send(method: .DELETE, path: StripeAPIEndpoint.externalAccounts(account, id).endpoint)
    }
    
    public func listAll(account: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeBankAccountList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return try request.send(method: .GET, path: StripeAPIEndpoint.externalAccount(account).endpoint, query: queryParams)
    }
    
    public func create(account: String, card: Any, defaultForCurrency: Bool?, metadata: [String: String]?) throws -> EventLoopFuture<StripeCard> {
        var body: [String: Any] = [:]
        
        if let cardToken = card as? String {
            body["external_account"] = cardToken
        } else if let cardDetails = card as? [String: Any] {
            cardDetails.forEach { body["external_account[\($0)]"] = $1 }
        }
        
        if let defaultForCurrency = defaultForCurrency {
            body["default_for_currency"] = defaultForCurrency
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.externalAccount(account).endpoint, body: body.queryParameters)
    }
    
    public func retrieve(account: String, id: String) throws -> EventLoopFuture<StripeCard> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.externalAccounts(account, id).endpoint)
    }
    
    public func update(account: String,
                       id: String,
                       addressCity: String?,
                       addressCountry: String?,
                       addressLine1: String?,
                       addressLine2: String?,
                       addressState: String?,
                       addressZip: String?,
                       defaultForCurrency: Bool?,
                       expMonth: Int?,
                       expYear: Int?,
                       metadata: [String: String]?,
                       name: String?) throws -> EventLoopFuture<StripeCard> {
        var body: [String: Any] = [:]
        
        if let addressCity = addressCity {
            body["address_city"] = addressCity
        }
        
        if let addressCountry = addressCountry {
            body["address_country"] = addressCountry
        }
        
        if let addressLine1 = addressLine1 {
            body["address_line1"] = addressLine1
        }
        
        if let addressLine2 = addressLine2 {
            body["address_line2"] = addressLine2
        }
        
        if let addressState = addressState {
            body["address_state"] = addressState
        }
        
        if let addressZip = addressZip {
            body["address_zip"] = addressZip
        }
        
        if let defaultForCurrency = defaultForCurrency {
            body["default_for_currency"] = defaultForCurrency
        }
        
        if let expMonth = expMonth {
            body["exp_month"] = expMonth
        }
        
        if let expYear = expYear {
            body["exp_year"] = expYear
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let name = name {
            body["name"] = name
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.externalAccounts(account, id).endpoint, body: body.queryParameters)
    }
    
    public func deleteCard(account: String, id: String) throws -> EventLoopFuture<StripeDeletedObject> {
        return try request.send(method: .DELETE, path: StripeAPIEndpoint.externalAccounts(account, id).endpoint)
    }
    
    public func listAll(account: String, filter: [String: Any]?) throws -> EventLoopFuture<StripeCardList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return try request.send(method: .GET, path: StripeAPIEndpoint.externalAccount(account).endpoint, query: queryParams)
    }
}
