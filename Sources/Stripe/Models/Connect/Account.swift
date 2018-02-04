//
//  Account.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation

/**
 Account object
 https://stripe.com/docs/api#account_object
 */

public protocol ConnectAccount {
    associatedtype PS: PayoutSchedule
    associatedtype TOSA: TOSAcceptance
    associatedtype AV: AccountVerification
    associatedtype LE: LegalEntity
    
    var id: String? { get }
    var object: String? { get }
    var businessName: String? { get }
    var businessUrl: String? { get }
    var chargesEnabled: Bool? { get }
    var country: String? { get }
    var created: Date? { get }
    var debitNegativeBalances: Bool? { get }
    var declineChargeOn: [String: Bool]? { get }
    var defaultCurrency: StripeCurrency? { get }
    var detailsSubmitted: Bool? { get }
    var displayName: String? { get }
    var email: String? { get }
    var externalAccounts: ExternalAccountsList? { get }
    var legalEntity: LE? { get }
    var metadata: [String: String]? { get }
    var payoutSchedule: PS? { get }
    var payoutStatementDescriptor: String? { get }
    var payoutsEnabled: Bool? { get }
    var productDescription: String? { get }
    var statementDescriptor: String? { get }
    var supportEmail: String? { get }
    var supportPhone: String? { get }
    var timezone: String? { get }
    var tosAcceptance: TOSA? { get }
    var type: ConnectedAccountType? { get }
    var verification: AV? { get }
    var transfersEnabled: Bool? { get }
}

public struct StripeConnectAccount: ConnectAccount, StripeModel {
    public var id: String?
    public var object: String?
    public var businessName: String?
    public var businessUrl: String?
    public var chargesEnabled: Bool?
    public var country: String?
    public var created: Date?
    public var debitNegativeBalances: Bool?
    public var declineChargeOn: [String : Bool]?
    public var defaultCurrency: StripeCurrency?
    public var detailsSubmitted: Bool?
    public var displayName: String?
    public var email: String?
    public var externalAccounts: ExternalAccountsList?
    public var legalEntity: StripeConnectAccountLegalEntity?
    public var metadata: [String: String]?
    public var payoutSchedule: StripePayoutSchedule?
    public var payoutStatementDescriptor: String?
    public var payoutsEnabled: Bool?
    public var productDescription: String?
    public var statementDescriptor: String?
    public var supportEmail: String?
    public var supportPhone: String?
    public var timezone: String?
    public var tosAcceptance: StripeTOSAcceptance?
    public var type: ConnectedAccountType?
    public var verification: StripeAccountVerification?
    public var transfersEnabled: Bool?
}
