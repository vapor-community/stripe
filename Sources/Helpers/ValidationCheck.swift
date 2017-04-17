//
//  ValidationCheck.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

public enum ValidationCheck: String {
    case pass = "pass"
    case faile = "fail"
    case unavailable = "unavailable"
    case unchecked = "unchecked"
}

extension ValidationCheck {
    public init?(optionalRawValue: String?) {
        if let rawValue = optionalRawValue {
            if let value = ValidationCheck(rawValue: rawValue) {
                self = value
            }
        }
        return nil
    }
}
