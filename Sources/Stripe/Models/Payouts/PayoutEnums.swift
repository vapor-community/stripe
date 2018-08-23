//
//  PayoutMethod.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/20/18.
//

import Vapor

public enum StripePayoutFailureCode: String, Content {
    case accountClosed = "account_closed"
    case accountFrozen = "account_frozen"
    case bankAccountRestricted = "bank_account_restricted"
    case bankOwnershipChanged = "bank_ownership_changed"
    case couldNotProcess = "could_not_process"
    case debitNotAuthorized = "debit_not_authorized"
    case declined
    case insufficientFunds = "insufficient_funds"
    case invalidAccountNumber = "invalid_account_number"
    case invalidAccountHolderName = "invalid_account_holder_name"
    case invalidCurrency = "invalid_currency"
    case noAccount = "no_account"
    case unsupportedCard = "unsupported_card"
}

public enum StripePayoutMethod: String, Content {
    case standard
    case instant
}

public enum StripePayoutStatus: String, Content {
    case paid
    case pending
    case inTransit = "in_transit"
    case canceled
    case failed
}

public enum StripePayoutSourceType: String, Content {
    case alipayAccount = "alipay_account"
    case bankAccount = "bank_account"
    case card
}

public enum StripePayoutType: String, Content {
    case bankAccount = "bank_account"
    case card
}
