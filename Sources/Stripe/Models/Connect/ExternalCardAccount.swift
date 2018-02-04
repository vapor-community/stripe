//
//  ExternalCardAccount.swift
//  Stripe
//
//  Created by Andrew Edwards on 1/20/18.
//

import Foundation

public struct StripeExternalCardAccount: ExternalAccount, StripeModel {
    public var object: String = "card"
    public var currency: StripeCurrency?
    public var defaultForCurrency: Bool?
    public var expMonth: Int?
    public var expYear: Int?
    public var number: String?
    public var addressCity: String?
    public var addressCountry: String?
    public var addressLine1: String?
    public var addressLine2: String?
    public var addressState: String?
    public var addressZip: String?
    public var cvc: String?
    public var metadata: [String: String]?
    public var name: String?
}
