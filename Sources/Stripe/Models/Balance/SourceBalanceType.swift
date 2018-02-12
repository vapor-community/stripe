//
//  SourceBalanceType.swift
//  Stripe
//
//  Created by Andrew Edwards on 2/11/18.
//

public enum SourceBalanceType: String, Codable {
    case card
    case bankAccount = "bank_account"
    case alipayAccount = "alipay_account"
}
