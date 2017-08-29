//
//  AccountRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation
import Node
import HTTP

public final class AccountRoutes {
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    public func create(type: ConnectedAccountType, email: String?, country: String?, metadata: Node? = nil) throws -> StripeRequest<ConnectAccount> {
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
    
    public func retrieve(account accountId: String) throws -> StripeRequest<ConnectAccount> {
        return try StripeRequest(client: self.client, method: .get, route: .accounts(accountId), query: [:], body: nil, headers: nil)
    }
    
    public func update(account accountId: String, businessName: String?, businessPrimaryColor: String?, businessUrl: String?, debitNegativeBalances: Bool?, declineChargeOn: Node?, defaultCurrency: StripeCurrency?, email: String?, externalAccount: Node?, legalEntity: Node?, payoutSchedule: Node?, payoutStatementDescriptor: String?, productDescription: String?, statementDescriptor: String?, supportEmail: String?, supportPhone: String?, supportUrl: String?, tosAcceptance: Node?, metadata: Node? = nil) throws -> StripeRequest<ConnectAccount> {
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
    
    public func delete(account accountId: String) throws -> StripeRequest<DeletedObject> {
        return try StripeRequest(client: self.client, method: .delete, route: .accounts(accountId), query: [:], body: nil, headers: nil)
    }
    
    public func reject(account accountId: String, for reason: AccountRejectReason) throws -> StripeRequest<ConnectAccount> {
        var body = Node([:])
        
        body["reason"] = Node(reason.rawValue)
        
        return try StripeRequest(client: self.client, method: .post, route: .accountsReject(accountId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    public func listAll(filter: StripeFilter? = nil) throws -> StripeRequest<AccountList> {
        var query = [String : NodeRepresentable]()
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .account, query: query, body: nil, headers: nil)
    }
    
    public func createLoginLink(forAccount accountId: String) throws -> StripeRequest<ConnectLoginLink> {
        return try StripeRequest(client: self.client, method: .post, route: .accountsLoginLink(accountId), query: [:], body: nil, headers: nil)
    }
}
