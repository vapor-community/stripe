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

extension FundingType {
    public init?(optionalRawValue: String?) {
        if let rawValue = optionalRawValue {
            if let value = FundingType(rawValue: rawValue) {
                self = value
            }
        }
        return nil
    }
}
