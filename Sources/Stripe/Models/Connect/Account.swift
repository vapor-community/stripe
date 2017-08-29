//
//  Account.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation
import Vapor


/**
 Account Model
 https://stripe.com/docs/api#account_object
 */

public final class ConnectAccount: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var businessName: String?
    public private(set) var businessUrl: String?
    public private(set) var chargesEnabled: Bool?
    //public private(set) var transfersEnabled: Bool?
    public private(set) var country: String?
    public private(set) var debitNegativeBalances: Bool?
    public private(set) var declineChargeOn: Node?
    public private(set) var defaultCurrency: StripeCurrency?
    public private(set) var detailsSubmitted: Bool?
    public private(set) var displayName: String?
    public private(set) var email: String?
    public private(set) var externalAccounts: ExternalAccounts?
    public private(set) var legalEntity: LegalEntity?
    public private(set) var metadata: Node?
    public private(set) var payoutSchedule: PayoutSchedule?
    public private(set) var payoutStatementDescriptor: String?
    public private(set) var payoutsEnabled: Bool?
    public private(set) var productDescription: String?
    public private(set) var statementDescriptor: String?
    public private(set) var supportEmail: String?
    public private(set) var supportPhone: String?
    public private(set) var timezone: String?
    public private(set) var tosAcceptance: TOSAcceptance?
    public private(set) var type: String?
    public private(set) var verification: Verification?
    public private(set) var keys: Node?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.businessName = try node.get("business_name")
        self.businessUrl = try node.get("business_url")
        self.chargesEnabled = try node.get("charges_enabled")
        // TODO - investigate, not getting value from response after rejecting account. 
        // https://stripe.com/docs/api/curl#reject_account
        // self.transfersEnabled = try node.get("transfers_enabled")
        self.country = try node.get("country")
        self.debitNegativeBalances = try node.get("debit_negative_balances")
        self.declineChargeOn = try node.get("decline_charge_on")
        if let currency = node["default_currency"]?.string {
            self.defaultCurrency = StripeCurrency(rawValue: currency)
        }
        self.detailsSubmitted = try node.get("details_submitted")
        self.displayName = try node.get("display_name")
        self.email = try node.get("email")
        self.externalAccounts = try node.get("external_accounts")
        self.legalEntity = try node.get("legal_entity")
        self.metadata = try node.get("metadata")
        self.payoutSchedule = try node.get("payout_schedule")
        self.payoutStatementDescriptor = try node.get("payout_statement_descriptor")
        self.payoutsEnabled = try node.get("payouts_enabled")
        self.productDescription = try node.get("product_description")
        self.statementDescriptor = try node.get("statement_descriptor")
        self.supportEmail = try node.get("support_email")
        self.supportPhone = try node.get("support_phone")
        self.timezone = try node.get("timezone")
        self.tosAcceptance = try node.get("tos_acceptance")
        self.type = try node.get("type")
        self.verification = try node.get("verification")
        self.keys = try node.get("keys")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "business_name": self.businessName,
            "business_url": self.businessUrl,
            "charges_enabled": self.chargesEnabled,
            //"transfers_enabled": self.transfersEnabled,
            "country": self.country,
            "debit_negative_balances": self.debitNegativeBalances,
            "decline_charge_on": self.declineChargeOn,
            "default_currency": self.defaultCurrency?.rawValue,
            "details_submitted": self.detailsSubmitted,
            "display_name": self.displayName,
            "email": self.email,
            "external_accounts": self.externalAccounts,
            "legal_entity": self.legalEntity,
            "metadata": self.metadata,
            "payout_schedule": self.payoutSchedule,
            "payout_statement_descriptor": self.payoutStatementDescriptor,
            "payouts_enabled": self.payoutsEnabled,
            "product_description": self.productDescription,
            "statement_descriptor": self.statementDescriptor,
            "support_email": self.supportEmail,
            "support_phone": self.supportPhone,
            "timezone": self.timezone,
            "tos_acceptance": self.tosAcceptance,
            "type": self.type,
            "verification": self.verification,
            "keys": self.keys
        ]
        
        return try Node(node: object)
    }
}
