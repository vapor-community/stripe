//
//  TokenizedMethod.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

public enum TokenizedMethod: String {
    case applePay = "apple_pay"
    case androidPay = "android_pay"
}

extension TokenizedMethod {
    public init?(optionalRawValue: String?) {
        if let rawValue = optionalRawValue {
            if let value = TokenizedMethod(rawValue: rawValue) {
                self = value
            }
        }
        return nil
    }
}
