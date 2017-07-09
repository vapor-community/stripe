//
//  StripeStatus.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

public enum StripeStatus: String {
    case success = "success"
    case succeeded = "succeeded"
    case failed = "failed"
    case pending = "pending"
    case canceled = "canceled"
    case chargeable = "chargeable"
}

public enum StripeSubscriptionStatus: String {
    case trailing = "trailing"
    case active = "active"
    case pastdue = "past_due"
    case canceled = "canceled"
    case unpaid = "unpaid"
}

public enum ConnectLegalEntityVerificationStatus: String {
    case unverified = "unverified"
    case pending = "pending"
    case verified = "verified"
}

public enum ConnectLegalEntityVerificationState: String {
    case scanCorrupt = "scan_corrupt"
    case scanNotReadable = "scan_not_readable"
    case scanFailedGreyScale = "scan_failed_greyscale"
    case scanNotUploaded = "scan_not_uploaded"
    case scanIdTypeNotUploaded = "scan_id_type_not_supported"
    case scanIdCountryNotSupported = "scan_id_country_not_supported"
    case scanNameMismatch = "scan_name_mismatch"
    case scanFailedOther = "scan_failed_other"
    case failedKeyedIdentity = "failed_keyed_identity"
    case failedOther = "failed_other"
}
