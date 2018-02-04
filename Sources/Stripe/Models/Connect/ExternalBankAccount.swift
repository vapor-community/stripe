//
//  ExternalBankAccount.swift
//  Stripe
//
//  Created by Andrew Edwards on 1/20/18.
//

import Foundation

public struct StripeExternalBankAccount: ExternalAccount, StripeModel {
    public var object: String = "bank_account"
    public var accountNumber: String?
    public var country: String?
    public var currency: StripeCurrency?
    public var accountHolderName: String?
    public var accountHolderType: String?
    public var routingNumber: String?
}
