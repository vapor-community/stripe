//
//  AccountRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Vapor

public protocol AccountRoutes {
    func create(type: ConnectedAccountType, email: String?, country: String?, accountToken: String?, businessLogo: String?, businessName: String?, businessPrimaryColor: String?, businessUrl: String?, debitNegativeBalances: Bool?, declineChargeOn: [String: Bool]?, defaultCurrency: StripeCurrency?, externalAccount: Any?, legalEntity: StripeConnectAccountLegalEntity?, metadata: [String: String]?, payoutSchedule: [String: String]?, payoutStatementDescriptor: String?, productDescription: String?, statementDescriptor: String?, supportEmail: String?, supportPhone: String?, supportUrl: String?, tosAcceptance: StripeTOSAcceptance?) throws -> Future<StripeConnectAccount>
    func retrieve(account: String) throws -> Future<StripeConnectAccount>
    func update(account: String, businessName: String?, businessPrimaryColor: String?, businessUrl: String?, debitNegativeBalances: Bool?, declineChargeOn: [String: Bool]?, defaultCurrency: StripeCurrency?, email: String?, externalAccount: Any?, legalEntity: StripeConnectAccountLegalEntity?, metadata: [String: String]?, payoutSchedule: [String: String]?, payoutStatementDescriptor: String?, productDescription: String?, statementDescriptor: String?, supportEmail: String?, supportPhone: String?, supportUrl: String?, tosAcceptance: StripeTOSAcceptance?) throws -> Future<StripeConnectAccount>
    func delete(account: String) throws -> Future<StripeDeletedObject>
    func reject(account: String, for: AccountRejectReason) throws -> Future<StripeConnectAccount>
    func listAll(filter: [String: Any]?) throws -> Future<ConnectedAccountsList>
    func createLoginLink(for: String) throws -> Future<StripeConnectLoginLink>
}

extension AccountRoutes {
    public func create(type: ConnectedAccountType,
                       email: String? = nil,
                       country: String? = nil,
                       accountToken: String? = nil,
                       businessLogo: String? = nil,
                       businessName: String? = nil,
                       businessPrimaryColor: String? = nil,
                       businessUrl: String? = nil,
                       debitNegativeBalances: Bool? = nil,
                       declineChargeOn: [String: Bool]? = nil,
                       defaultCurrency: StripeCurrency? = nil,
                       externalAccount: Any? = nil,
                       legalEntity: StripeConnectAccountLegalEntity? = nil,
                       metadata: [String: String]? = nil,
                       payoutSchedule: [String: String]? = nil,
                       payoutStatementDescriptor: String? = nil,
                       productDescription: String? = nil,
                       statementDescriptor: String? = nil,
                       supportEmail: String? = nil,
                       supportPhone: String? = nil,
                       supportUrl: String? = nil,
                       tosAcceptance: StripeTOSAcceptance? = nil) throws -> Future<StripeConnectAccount> {
        return try create(type: type,
                          email: email,
                          country: country,
                          accountToken: accountToken,
                          businessLogo: businessLogo,
                          businessName: businessName,
                          businessPrimaryColor: businessPrimaryColor,
                          businessUrl: businessUrl,
                          debitNegativeBalances: debitNegativeBalances,
                          declineChargeOn: declineChargeOn,
                          defaultCurrency: defaultCurrency,
                          externalAccount: externalAccount,
                          legalEntity: legalEntity,
                          metadata: metadata,
                          payoutSchedule: payoutSchedule,
                          payoutStatementDescriptor: payoutStatementDescriptor,
                          productDescription: productDescription,
                          statementDescriptor: statementDescriptor,
                          supportEmail: supportEmail,
                          supportPhone: supportPhone,
                          supportUrl: supportUrl,
                          tosAcceptance: tosAcceptance)
    }
    
    public func retrieve(account: String) throws -> Future<StripeConnectAccount> {
        return try retrieve(account: account)
    }
    
    public func update(account accountId: String,
                       businessName: String? = nil,
                       businessPrimaryColor: String? = nil,
                       businessUrl: String? = nil,
                       debitNegativeBalances: Bool? = nil,
                       declineChargeOn: [String : Bool]? = nil,
                       defaultCurrency: StripeCurrency? = nil,
                       email: String? = nil,
                       externalAccount: Any? = nil,
                       legalEntity: StripeConnectAccountLegalEntity? = nil,
                       metadata: [String : String]? = nil,
                       payoutSchedule: [String : String]? = nil,
                       payoutStatementDescriptor: String? = nil,
                       productDescription: String? = nil,
                       statementDescriptor: String? = nil,
                       supportEmail: String? = nil,
                       supportPhone: String? = nil,
                       supportUrl: String? = nil,
                       tosAcceptance: StripeTOSAcceptance? = nil) throws -> Future<StripeConnectAccount> {
        return try update(account: accountId,
                          businessName: businessName,
                          businessPrimaryColor: businessPrimaryColor,
                          businessUrl: businessUrl,
                          debitNegativeBalances: debitNegativeBalances,
                          declineChargeOn: declineChargeOn,
                          defaultCurrency: defaultCurrency,
                          email: email,
                          externalAccount: externalAccount,
                          legalEntity: legalEntity,
                          metadata: metadata,
                          payoutSchedule: payoutSchedule,
                          payoutStatementDescriptor: payoutStatementDescriptor,
                          productDescription: productDescription,
                          statementDescriptor: statementDescriptor,
                          supportEmail: supportEmail,
                          supportPhone: supportPhone,
                          supportUrl: supportUrl,
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
    public func create(type: ConnectedAccountType,
                       email: String?,
                       country: String?,
                       accountToken: String?,
                       businessLogo: String?,
                       businessName: String?,
                       businessPrimaryColor: String?,
                       businessUrl: String?,
                       debitNegativeBalances: Bool?,
                       declineChargeOn: [String: Bool]?,
                       defaultCurrency: StripeCurrency?,
                       externalAccount: Any?,
                       legalEntity: StripeConnectAccountLegalEntity?,
                       metadata: [String: String]?,
                       payoutSchedule: [String: String]?,
                       payoutStatementDescriptor: String?,
                       productDescription: String?,
                       statementDescriptor: String?,
                       supportEmail: String?,
                       supportPhone: String?,
                       supportUrl: String?,
                       tosAcceptance: StripeTOSAcceptance?) throws -> Future<StripeConnectAccount> {
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
        
        if let businessLogo = businessLogo {
            body["business_logo"] = businessLogo
        }
        
        if let businessname = businessName {
            body["business_name"] = businessname
        }
        
        if let businesscolor = businessPrimaryColor {
            body["business_primary_color"] = businesscolor
        }
        
        if let businessurl = businessUrl {
            body["business_url"] = businessurl
        }
        
        if let debNegBal = debitNegativeBalances {
            body["debit_negative_balances"] = debNegBal
        }
        
        if let declinechargeon = declineChargeOn {
            declinechargeon.forEach { body["decline_charge_on[\($0)]"] = $1 }
        }
        
        if let currency = defaultCurrency {
            body["default_currency"] = currency.rawValue
        }
        
        if let externalAccountToken = externalAccount as? String {
            body["external_account"] = externalAccountToken
        } else if let externalBankAccount = externalAccount as? StripeExternalBankAccount {
            try externalBankAccount.toEncodedDictionary().forEach { body["external_account[\($0)]"] = $1 }
        } else if let externalCardAccount = externalAccount as? StripeExternalCardAccount {
            try externalCardAccount.toEncodedDictionary().forEach { body["external_account[\($0)]"] = $1 }
        }
        
        if let legalEntity = legalEntity {
            try legalEntity.toEncodedDictionary().forEach { body["legal_entity[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let payoutSchedule = payoutSchedule {
            payoutSchedule.forEach { body["payout_schedule[\($0)]"] = $1 }
        }
        
        if let payoutstatement = payoutStatementDescriptor {
            body["payout_statement_descriptor"] = payoutstatement
        }
        
        if let productDescription = productDescription {
            body["product_description"] = productDescription
        }
        
        if let statementdescriptor = statementDescriptor {
            body["statement_descriptor"] = statementdescriptor
        }
        
        if let supportEmail = supportEmail {
            body["support_email"] = supportEmail
        }
        
        if let supportPhone = supportPhone {
            body["support_phone"] = supportPhone
        }
        
        if let supportUrl = supportUrl {
            body["support_url"] = supportUrl
        }
        
        if let tos = tosAcceptance {
            try tos.toEncodedDictionary().forEach { body["tos_acceptance[\($0)]"] = $1 }
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
                       businessName: String?,
                       businessPrimaryColor: String?,
                       businessUrl: String?,
                       debitNegativeBalances: Bool?,
                       declineChargeOn: [String : Bool]?,
                       defaultCurrency: StripeCurrency?,
                       email: String?,
                       externalAccount: Any?,
                       legalEntity: StripeConnectAccountLegalEntity?,
                       metadata: [String : String]?,
                       payoutSchedule: [String : String]?,
                       payoutStatementDescriptor: String?,
                       productDescription: String?,
                       statementDescriptor: String?,
                       supportEmail: String?,
                       supportPhone: String?,
                       supportUrl: String?,
                       tosAcceptance: StripeTOSAcceptance?) throws -> Future<StripeConnectAccount> {
        var body: [String: Any] = [:]
        
        if let businessname = businessName {
            body["business_name"] = businessname
        }
        
        if let businesscolor = businessPrimaryColor {
            body["business_primary_color"] = businesscolor
        }
        
        if let businessurl = businessUrl {
            body["business_url"] = businessurl
        }
        
        if let debNegBal = debitNegativeBalances {
            body["debit_negative_balances"] = debNegBal
        }
        
        if let declinechargeon = declineChargeOn {
            declinechargeon.forEach { body["decline_charge_on[\($0)]"] = $1 }
        }
        
        if let currency = defaultCurrency {
            body["default_currency"] = currency.rawValue
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let externalBankAccount = externalAccount as? StripeExternalBankAccount {
            try externalBankAccount.toEncodedDictionary().forEach { body["external_account[\($0)]"] = $1 }
        }
        
        if let externalCardAccount = externalAccount as? StripeExternalCardAccount {
            try externalCardAccount.toEncodedDictionary().forEach { body["external_account[\($0)]"] = $1 }
        }
        
        if let legalEntity = legalEntity {
            try legalEntity.toEncodedDictionary().forEach { body["legal_entity[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let payoutSchedule = payoutSchedule {
            payoutSchedule.forEach { body["payout_schedule[\($0)]"] = $1 }
        }
        
        if let payoutstatement = payoutStatementDescriptor {
            body["payout_statement_descriptor"] = payoutstatement
        }
        
        if let productDescription = productDescription {
            body["product_description"] = productDescription
        }
        
        if let statementdescriptor = statementDescriptor {
            body["statement_descriptor"] = statementdescriptor
        }
        
        if let supportEmail = supportEmail {
            body["support_email"] = supportEmail
        }
        
        if let supportPhone = supportPhone {
            body["support_phone"] = supportPhone
        }
        
        if let supportUrl = supportUrl {
            body["support_url"] = supportUrl
        }
        
        if let tos = tosAcceptance {
            try tos.toEncodedDictionary().forEach { body["tos_acceptance[\($0)]"] = $1 }
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
