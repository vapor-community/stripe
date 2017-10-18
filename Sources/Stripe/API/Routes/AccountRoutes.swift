//
//  AccountRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Node
import HTTP

public final class AccountRoutes {
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Create an account
     With Connect, you can create Stripe accounts for your users. To do this, you'll first need to register your platform.
     
     - parameter type:     Whether you'd like to create a Custom or Standard account. Custom accounts have extra parameters 
                           available to them, and require that you, the platform, handle all communication with the account 
                           holder. Standard accounts are normal Stripe accounts: Stripe will email the account holder to setup 
                           a username and password, and handle all account management directly with them. Possible values are 
                           custom and standard.
     - parameter email:    The email address of the account holder. For Standard accounts, Stripe will email your user with 
                           instructions for how to set up their account. For Custom accounts, this is only to make the account 
                           easier to identify to you: Stripe will never directly reach out to your users.
     - parameter country:  The country the account holder resides in or that the business is legally established in. For example, 
                           if you are in the United States and the business you're creating an account for is legally represented 
                           in Canada, you would use "CA" as the country for the account being created. This should be an ISO 3166-1 
                           alpha-2 country code.
     - parameter metadata: A set of key/value pairs that you can attach to an account object. It can be useful for storing additional 
                           information about the account in a structured format. You can unset individual keys  if you POST an empty 
                           value for that key. You can clear all keys if you POST an empty value for metadata.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func create(type: ConnectedAccountType, email: String? = nil, country: String? = nil, metadata: Node? = nil) throws -> StripeRequest<ConnectAccount> {
        var body = Node([:])
        
        body["type"] = Node(type.rawValue)
        
        if let email = email {
            body["email"] = Node(email)
        }
        
        if let country = country {
            body["country"] = Node(country)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .account, query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Retrieve account details
     Retrieves the details of the account.
     
     - parameter accountId: The identifier of the account to be retrieved. If none is provided, 
                            will default to the account of the API key.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func retrieve(account accountId: String) throws -> StripeRequest<ConnectAccount> {
        return try StripeRequest(client: self.client, method: .get, route: .accounts(accountId), query: [:], body: nil, headers: nil)
    }
    
    /**
     Update an account
     Updates an account by setting the values of the parameters passed. Any parameters not provided will 
     be left unchanged.
     You may only update Custom and Express accounts that you manage. To update your own account, 
     you can currently only do so via the dashboard.
     
     - parameter accountId:                 The account ID to update on to
     - parameter bussinessName:             The publicly sharable name for this account.
     - parameter bussinessPrimaryColor:     A CSS hex color value representing the primary branding color for this account.
     - parameter businessUrl:               The URL that best shows the service or product provided for this account.
     - parameter debitNegativeBalances:     A boolean for whether or not Stripe should try to reclaim negative balances
                                            from the account holder’s bank account.
     - parameter declineChargeOn:           Account-level settings to automatically decline certain types of charges
                                            regardless of the bank’s decision.
     - parameter defaultCurrency:           Three-letter ISO currency code representing the default currency for the account
     - parameter email:                     Email address of the account holder. For Standard accounts, this is used to email
                                            them asking them to claim their Stripe account. For Custom accounts, this is only
                                            to make the account easier to identify to you: Stripe will not email the account holder.
     - parameter externalAccount:           A card or bank account to attach to the account. You can provide either a token,
                                            like the ones returned by Stripe.js, or a dictionary as documented in the external_account
                                            parameter for bank account creation. This will create a new external account object, make it
                                            the new default external account for its currency, and delete the old default if one exists.
                                            If you want to add additional external accounts instead of replacing the existing default for 
                                            this currency, use the bank account or card creation API.
     - parameter legalEntity:               Information about the account holder; varies by account country and account status.
     - parameter payoutSchedule:            Details on when this account will make funds from charges available, and when they will be 
                                            paid out to the account holder’s bank account.
     - parameter payoutStatementDescriptor: The text that will appear on the account’s bank account statement for payouts. If not set, this 
                                            will default to your platform’s bank descriptor set on the Dashboard. This will be unset if you 
                                            POST an empty value.
     - parameter productDescription:        Internal-only description of the product being sold or service being provided by this account. 
                                            It’s used by Stripe for risk and underwriting purposes.
     - parameter statementDescriptor:       The text that will appear on credit card statements by default if a charge is being made 
                                            directly on the account.
     - parameter supportEmail:              A publicly shareable email address that can be reached for support for this account.
     - parameter supportPhone:              A publicly shareable phone number that can be reached for support for this account.
     - parameter supportUrl:                A publicly shareable URL that can be reached for support for this account.
     - parameter tosAcceptance:             Details on who accepted the Stripe terms of service, and when they accepted it.
     - paramater metadata:                  A set of key/value pairs that you can attach to an account object. It can be useful for storing 
                                            additional information about the account in a structured format. You can unset individual keys 
                                            if you POST an empty value for that key. You can clear all keys if you POST an empty value for metadata.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func update(account accountId: String, businessName: String? = nil, businessPrimaryColor: String? = nil, businessUrl: String? = nil, debitNegativeBalances: Bool? = nil, declineChargeOn: Node? = nil, defaultCurrency: StripeCurrency? = nil, email: String? = nil, externalAccount: Node? = nil, legalEntity: Node? = nil, payoutSchedule: Node? = nil, payoutStatementDescriptor: String? = nil, productDescription: String? = nil, statementDescriptor: String? = nil, supportEmail: String? = nil, supportPhone: String? = nil, supportUrl: String? = nil, tosAcceptance: Node? = nil, metadata: Node? = nil) throws -> StripeRequest<ConnectAccount> {
        var body = Node([:])
        
        if let businessname = businessName {
            body["business_name"] = Node(businessname)
        }
        
        if let businesscolor = businessPrimaryColor {
            body["business_primary_color"] = Node(businesscolor)
        }
        
        if let businessurl = businessUrl {
            body["business_url"] = Node(businessurl)
        }
        
        if let debNegBal = debitNegativeBalances {
            body["debit_negative_balances"] = Node(debNegBal)
        }
        
        if let declinechargeon = declineChargeOn?.object {
            for (key, value) in declinechargeon {
                body["decline_charge_on[\(key)]"] = value
            }
        }
        
        if let currency = defaultCurrency {
            body["default_currency"] = Node(currency.rawValue)
        }
        
        if let email = email {
            body["email"] = Node(email)
        }
        
        if let externalaccount = externalAccount?.object {
            for (key,value) in externalaccount {
                body["external_account[\(key)]"] = value
            }
        }
        
        if let legalentity = legalEntity {
            
            if let directors = legalentity["additional_directors"]?.object {
                
                for (key,value) in directors {
                    body["legal_entity[additional_directors][\(key)]"] = value
                }
            }
            
            if let owners = legalentity["additional_owners"]?.array {
                
                for index in 0..<owners.count {
                    
                    if let address = owners[index]["address"]?.object {
                        for (key,value) in address {
                            body["legal_entity[additional_owners]"]?[index]?["address[\(key)]"] = value
                        }
                    }
                    
                    if let dob = owners[index]["dob"]?.object {
                        for (key,value) in dob {
                            body["legal_entity[additional_owners]"]?[index]?["dob][\(key)]"] = value
                        }
                    }
                    
                    if let firstname = owners[index]["first_name"]?.string {
                        body["legal_entity[additional_owners]"]?[index]?["first_name"] = Node(firstname)
                    }
                    
                    if let lastname = owners[index]["last_name"]?.string {
                        body["legal_entity[additional_owners"]?[index]?["last_name"] = Node(lastname)
                    }
                    
                    if let verification = owners[index]["verification"]?.object {
                        for(key, value) in verification {
                            body["legal_entity[additional_owners"]?[index]?["verification][\(key)]"] = value
                        }
                    }
                }
            }
            
            if let address = legalentity["address"]?.object {
                for (key, value) in address {
                    body["legal_entity[address][\(key)]"] = value
                }
            }
            
            if let businessname = legalentity["business_name"]?.string {
                body["legal_entity[business_name]"] = Node(businessname)
            }
            
            if let businesstax = legalentity["business_tax_id"]?.string {
                body["legal_entity[business_tax_id]"] = Node(businesstax)
            }
            
            if let businessvat = legalentity["business_vat_id"]?.string {
                body["legal_entity[business_vat_id]"] = Node(businessvat)
            }
            
            if let director = legalentity["director"]?.string {
                body["legal_entity[director]"] = Node(director)
            }
            
            if let dob = legalentity["dob"]?.object {
                for (key,value) in dob {
                    body["legal_entity[dob][\(key)]"] = value
                }
            }
            
            if let firstname = legalentity["first_name"]?.string {
                body["legal_entity[first_name]"] = Node(firstname)
            }
            
            if let lastname = legalentity["last_name"]?.string {
                body["legal_entity[last_name]"] = Node(lastname)
            }
            
            if let gender = legalentity["gender"]?.string {
                body["legal_entity[gender]"] = Node(gender)
            }
            
            if let maiden = legalentity["maiden_name"]?.string {
                body["legal_entity[maiden_name]"] = Node(maiden)
            }
            
            if let personaladdress = legalentity["personal_address"]?.object {
                for (key, value) in personaladdress {
                    body["legal_entity[personal_address][\(key)]"] = value
                }
            }
            
            if let pid = legalentity["personal_id_number"]?.string {
                body["legal_entity[personal_id_number]"] = Node(pid)
            }
            
            if let phone = legalentity["phone_number"]?.string {
                body["legal_entity[phone_number]"] = Node(phone)
            }
            
            if let ssnLast4 = legalentity["ssn_last_4"]?.string {
                body["legal_entity[ssn_last_4]"] = Node(ssnLast4)
            }
            
            if let taxIdReg = legalentity["tax_id_registrar"]?.string {
                body["legal_entity[tax_id_registrar]"] = Node(taxIdReg)
            }
            
            if let type = legalentity["type"]?.string {
                body["legal_entity[type]"] = Node(type)
            }
            
            if let verification = legalentity["verification"]?.object {
                for (key, value) in verification {
                    body["legal_entity[verification][\(key)]"] = value
                }
            }
            
            if let metadata = legalentity["metadata"]?.object {
                for (key, value) in metadata {
                    body["legal_entity[metadata][\(key)]"] = value
                }
            }
        }
        
        if let payoutSchedule = payoutSchedule?.object {
            for (key, value) in payoutSchedule {
                body["payout_schedule[\(key)]"] = value
            }
        }
        
        if let payoutstatement = payoutStatementDescriptor?.string {
            body["payout_statement_descriptor"] = Node(payoutstatement)
        }
        
        if let productDescription = productDescription?.string {
            body["product_description"] = Node(productDescription)
        }
        
        if let statementdescriptor = statementDescriptor?.string {
            body["statement_descriptor"] = Node(statementdescriptor)
        }
        
        if let supportEmail = supportEmail?.string {
            body["support_email"] = Node(supportEmail)
        }
        
        if let supportPhone = supportPhone?.string {
            body["support_phone"] = Node(supportPhone)
        }
        
        if let supportUrl = supportUrl?.string {
            body["support_url"] = Node(supportUrl)
        }
        
        if let tosAcceptance = tosAcceptance?.object {
            for (key, value) in tosAcceptance {
                body["tos_acceptance[\(key)]"] = value
            }
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .accounts(accountId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Delete an account
     With Connect, you may delete Custom accounts you manage.
     Custom accounts created using test-mode keys can be deleted at any time. Custom accounts created 
     using live-mode keys may only be deleted once all balances are zero.
     If you are looking to close your own account, use the data tab in your account settings instead.
     
     - parameter accountId: The identifier of the account to be deleted. If none is provided, will default 
                            to the account of the API key.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func delete(account accountId: String) throws -> StripeRequest<DeletedObject> {
        return try StripeRequest(client: self.client, method: .delete, route: .accounts(accountId), query: [:], body: nil, headers: nil)
    }
    
    /**
     Reject an account
     With Connect, you may flag accounts as suspicious.
     Test-mode Custom and Express accounts can be rejected at any time. Accounts created using live-mode keys may only 
     be rejected once all balances are zero.
     
     - parameter accountId: The identifier of the account to create a login link for.
     - parameter reason: The reason for rejecting the account.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func reject(account accountId: String, for reason: AccountRejectReason) throws -> StripeRequest<ConnectAccount> {
        var body = Node([:])
        
        body["reason"] = Node(reason.rawValue)
        
        return try StripeRequest(client: self.client, method: .post, route: .accountsReject(accountId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     List all connected accounts
     Returns a list of accounts connected to your platform via Connect. If you’re not a platform, the list will be empty
     
     - parameter filter: A Filter item to pass query parameters when fetching results
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func listAll(filter: StripeFilter? = nil) throws -> StripeRequest<AccountList> {
        var query = [String : NodeRepresentable]()
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .account, query: query, body: nil, headers: nil)
    }
    
    /**
     Create a login link
     Creates a single-use login link for an Express account to access their Stripe dashboard.
     You may only create login links for Express accounts connected to your platform.
     
     - parameter accountId: The identifier of the account to create a login link for.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func createLoginLink(forAccount accountId: String) throws -> StripeRequest<ConnectLoginLink> {
        return try StripeRequest(client: self.client, method: .post, route: .accountsLoginLink(accountId), query: [:], body: nil, headers: nil)
    }
}
