//
//  AccountRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Vapor

public protocol AccountRoutes {
    func create(type: StripeConnectAccountType,
                country: String?,
                email: String?,
                accountToken: String?,
                businessProfile: [String: Any]?,
                businessType: StripeConnectAccountBusinessType?,
                company: [String: Any]?,
                defaultCurrency: StripeCurrency?,
                externalAccount: Any?,
                individual: [String: Any]?,
                metadata: [String: String]?,
                requestedCapabilities: [String]?,
                settings: [String: Any]?,
                tosAcceptance: [String: Any]?) throws -> Future<StripeConnectAccount>
    func retrieve(account: String) throws -> Future<StripeConnectAccount>
    func update(account accountId: String,
                accountToken: String?,
                businessProfile: [String: Any]?,
                businessType: StripeConnectAccountBusinessType?,
                company: [String: Any]?,
                defaultCurrency: StripeCurrency?,
                email: String?,
                externalAccount: Any?,
                individual: [String: Any]?,
                metadata: [String: String]?,
                requestedCapabilities: [String]?,
                settings: [String: Any]?,
                tosAcceptance: [String: Any]?) throws -> Future<StripeConnectAccount>
    func delete(account: String) throws -> Future<StripeDeletedObject>
    func reject(account: String, for: AccountRejectReason) throws -> Future<StripeConnectAccount>
    func listAll(filter: [String: Any]?) throws -> Future<ConnectedAccountsList>
    func createLoginLink(for: String) throws -> Future<StripeConnectLoginLink>
}

extension AccountRoutes {
    public func create(type: StripeConnectAccountType,
                       country: String? = nil,
                       email: String? = nil,
                       accountToken: String? = nil,
                       businessProfile: [String: Any]? = nil,
                       businessType: StripeConnectAccountBusinessType? = nil,
                       company: [String: Any]? = nil,
                       defaultCurrency: StripeCurrency? = nil,
                       externalAccount: Any? = nil,
                       individual: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       requestedCapabilities: [String]? = nil,
                       settings: [String: Any]? = nil,
                       tosAcceptance: [String: Any]? = nil) throws -> Future<StripeConnectAccount> {
        return try create(type: type,
                          country: country,
                          email: email,
                          accountToken: accountToken,
                          businessProfile: businessProfile,
                          businessType: businessType,
                          company: company,
                          defaultCurrency: defaultCurrency,
                          externalAccount: externalAccount,
                          individual: individual,
                          metadata: metadata,
                          requestedCapabilities: requestedCapabilities,
                          settings: settings,
                          tosAcceptance: tosAcceptance)
    }
    
    public func retrieve(account: String) throws -> Future<StripeConnectAccount> {
        return try retrieve(account: account)
    }
    
    public func update(account accountId: String,
                       accountToken: String? = nil,
                       businessProfile: [String: Any]? = nil,
                       businessType: StripeConnectAccountBusinessType? = nil,
                       company: [String: Any]? = nil,
                       defaultCurrency: StripeCurrency? = nil,
                       email: String? = nil,
                       externalAccount: Any? = nil,
                       individual: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       requestedCapabilities: [String]? = nil,
                       settings: [String: Any]? = nil,
                       tosAcceptance: [String: Any]? = nil) throws -> Future<StripeConnectAccount> {
        return try update(account: accountId,
                          accountToken: accountToken,
                          businessProfile: businessProfile,
                          businessType: businessType,
                          company: company,
                          defaultCurrency: defaultCurrency,
                          email: email,
                          externalAccount: externalAccount,
                          individual: individual,
                          metadata: metadata,
                          requestedCapabilities: requestedCapabilities,
                          settings: settings,
                          tosAcceptance: tosAcceptance)
    }
    
    public func delete(account: String) throws -> Future<StripeDeletedObject> {
        return try delete(account: account)
    }
    
    public func reject(account: String, for: AccountRejectReason) throws -> Future<StripeConnectAccount> {
        return try reject(account: account, for: `for`)
    }
    
    public func listAll(filter: [String: Any]? = nil) throws -> Future<ConnectedAccountsList> {
        return try listAll(filter: filter)
    }
    
    public func createLoginLink(for: String) throws -> Future<StripeConnectLoginLink> {
        return try createLoginLink(for: `for`)
    }
}

public struct StripeConnectAccountRoutes: AccountRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    /// Create an account
    /// [Learn More →](https://stripe.com/docs/api/curl#create_account)
    public func create(type: StripeConnectAccountType,
                       country: String?,
                       email: String?,
                       accountToken: String?,
                       businessProfile: [String: Any]?,
                       businessType: StripeConnectAccountBusinessType?,
                       company: [String: Any]?,
                       defaultCurrency: StripeCurrency?,
                       externalAccount: Any?,
                       individual: [String: Any]?,
                       metadata: [String: String]?,
                       requestedCapabilities: [String]?,
                       settings: [String: Any]?,
                       tosAcceptance: [String: Any]?) throws -> Future<StripeConnectAccount> {
        var body: [String: Any] = [:]
        body["type"] = type.rawValue
        
        if let country = country {
            body["country"] = country
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let accountToken = accountToken {
            body["account_token"] = accountToken
        }
        
        if let businessProfile = businessProfile {
            businessProfile.forEach { body["business_profile[\($0)]"] = $1 }
        }
        
        if let businessType = businessType {
            body["business_type"] = businessType.rawValue
        }
        
        if let company = company {
            company.forEach { body["company[\($0)]"] = $1 }
        }
        
        if let currency = defaultCurrency {
            body["default_currency"] = currency.rawValue
        }
        
        if let externalAccountToken = externalAccount as? String {
            body["external_account"] = externalAccountToken
        } else if let externalHashAccount = externalAccount as? [String: Any] {
            externalHashAccount.forEach { body["external_account[\($0)]"] = $1 }
        }
        
        if let individual = individual {
            individual.forEach { body["individual[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let requestedCapabilities = requestedCapabilities {
            body["requested_capabilities"] = requestedCapabilities
        }
        
        if let settings = settings {
            settings.forEach { body["settings[\($0)]"] = $1 }
        }
        
        if let tos = tosAcceptance {
            tos.forEach { body["tos_acceptance[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.account.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve account details
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_account)
    public func retrieve(account accountId: String) throws -> Future<StripeConnectAccount> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.accounts(accountId).endpoint)
    }
    
    /// Update an account
    /// [Learn More →](https://stripe.com/docs/api/curl#update_account)
    public func update(account accountId: String,
                       accountToken: String?,
                       businessProfile: [String: Any]?,
                       businessType: StripeConnectAccountBusinessType?,
                       company: [String: Any]?,
                       defaultCurrency: StripeCurrency?,
                       email: String?,
                       externalAccount: Any?,
                       individual: [String: Any]?,
                       metadata: [String: String]?,
                       requestedCapabilities: [String]?,
                       settings: [String: Any]?,
                       tosAcceptance: [String: Any]?) throws -> Future<StripeConnectAccount> {
        var body: [String: Any] = [:]
        
        if let accountToken = accountToken {
            body["account_token"] = accountToken
        }
        
        if let businessProfile = businessProfile {
            businessProfile.forEach { body["business_profile[\($0)]"] = $1 }
        }
        
        if let businessType = businessType {
            body["business_type"] = businessType.rawValue
        }
        
        if let company = company {
            company.forEach { body["company[\($0)]"] = $1 }
        }
        
        if let currency = defaultCurrency {
            body["default_currency"] = currency.rawValue
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let externalAccountToken = externalAccount as? String {
            body["external_account"] = externalAccountToken
        } else if let externalHashAccount = externalAccount as? [String: Any] {
            externalHashAccount.forEach { body["external_account[\($0)]"] = $1 }
        }
        
        if let individual = individual {
            individual.forEach { body["individual[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let requestedCapabilities = requestedCapabilities {
            body["requested_capabilities"] = requestedCapabilities
        }
        
        if let settings = settings {
            settings.forEach { body["settings[\($0)]"] = $1 }
        }
        
        if let tos = tosAcceptance {
            tos.forEach { body["tos_acceptance[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.accounts(accountId).endpoint, body: body.queryParameters)
    }
    
    /// Delete an account
    /// [Learn More →](https://stripe.com/docs/api/curl#delete_account)
    public func delete(account accountId: String) throws -> Future<StripeDeletedObject> {
        return try request.send(method: .DELETE, path: StripeAPIEndpoint.accounts(accountId).endpoint)
    }
    
    /// Reject an account
    /// [Learn More →](https://stripe.com/docs/api/curl#reject_account)
    public func reject(account accountId: String, for rejectReason: AccountRejectReason) throws -> Future<StripeConnectAccount> {
        let body = ["reason": rejectReason.rawValue].queryParameters
        return try request.send(method: .POST, path: StripeAPIEndpoint.accountsReject(accountId).endpoint, body: body)
    }
    
    /// List all connected accounts
    /// [Learn More →](https://stripe.com/docs/api/curl#list_accounts)
    public func listAll(filter: [String: Any]?) throws -> Future<ConnectedAccountsList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return try request.send(method: .GET, path: StripeAPIEndpoint.account.endpoint, query: queryParams)
    }
    
    /// Create a login link
    /// [Learn More →](https://stripe.com/docs/api/curl#create_login_link)
    public func createLoginLink(for accountId: String) throws -> Future<StripeConnectLoginLink> {
        return try request.send(method: .POST, path: StripeAPIEndpoint.accountsLoginLink(accountId).endpoint)
    }
}
