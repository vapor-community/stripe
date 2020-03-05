//
//  FundingType.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

public enum FundingType: String, Codable {
    case credit
    case debit
    case prepaid
    case unknown
}
