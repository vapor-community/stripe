//
//  ValidationCheck.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

public enum CardValidationCheck: String, Codable {
    case pass
    case failed
    case unavailable
    case unchecked
}
