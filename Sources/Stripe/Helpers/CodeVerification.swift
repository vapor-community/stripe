//
//  CodeVerification.swift
//  Stripe
//
//  Created by Andrew Edwards on 12/4/17.
//

public struct CodeVerification: StripeModel {
    public var attemptsRemaining: Int?
    public var status: StripeStatus?
    
    public enum CodingKeys: CodingKey, String {
        case attemptsRemaining = "attempts_remaining"
        case status
    }
}
