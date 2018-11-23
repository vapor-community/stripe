//
//  StripeStatus.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

public enum StripeStatus: String, Codable {
    case success
    case succeeded
    case failed
    case pending
    case canceled
    case chargeable
}

// https://stripe.com/docs/api/curl#subscription_object-status
public enum StripeSubscriptionStatus: String, Codable {
    case trialing
    case active
    case pastDue = "past_due"
    case canceled
    case unpaid
}

// https://stripe.com/docs/api/invoices/object#invoice_object-status
public enum StripeInvoiceStatus: String, Codable {
    case draft
    case open
    case paid
    case uncollectible
    case void
}

public enum LegalEntityVerificationStatus: String, Codable {
    case unverified
    case pending
    case verified
}

public enum LegalEntityVerificationState: String, Codable {
    case scanCorrupt = "scan_corrupt"
    case scanNotReadable = "scan_not_readable"
    case scanFailedGreyscale = "scan_failed_greyscale"
    case scanNotUploaded = "scan_not_uploaded"
    case scanIdTypeNotUploaded = "scan_id_type_not_supported"
    case scanIdCountryNotSupported = "scan_id_country_not_supported"
    case scanNameMismatch = "scan_name_mismatch"
    case scanFailedOther = "scan_failed_other"
    case failedKeyedIdentity = "failed_keyed_identity"
    case failedOther = "failed_other"
}
