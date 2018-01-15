//
//  CodeVerification.swift
//  Stripe
//
//  Created by Andrew Edwards on 12/4/17.
//

public struct CodeVerification: StripeModelProtocol {
    public var attemptsRemaining: Int?
    public var status: String?
    
    enum CodingKeys: String, CodingKey {
        case attemptsRemaining = "attempts_remaining"
        case status
    }
}
