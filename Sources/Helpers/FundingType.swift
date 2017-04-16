//
//  FundingType.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

public enum FundingType: String {
    case credit = "credit"
    case debit = "debit"
    case prepaid = "prepaid"
    case unknown = "unknown"
}
