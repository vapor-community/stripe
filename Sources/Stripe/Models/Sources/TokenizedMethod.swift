//
//  TokenizedMethod.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation

public enum TokenizedMethod: String, Codable {
    case applePay
    case androidPay
    
    enum CodingKeys: String, CodingKey {
        case applePay = "apple_pay"
        case androidPay = "android_pay"
    }
}
