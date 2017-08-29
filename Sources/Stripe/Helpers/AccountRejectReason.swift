//
//  AccountRejectReason.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/9/17.
//
//

import Foundation

public enum AccountRejectReason: String {
    case fraud = "fraud"
    case termsOfService = "terms_of_service"
    case other = "other"
}
