//
//  SourceType.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/14/17.
//
//

import Foundation
import Errors

public enum SourceType {
    case card(amount: Int)
}

private enum RawSourceType: String {
    case card = "card"
}

public extension SourceType {
    public init(type: String, amount: Int) throws {
        guard let rawType = RawSourceType(rawValue: type.lowercased()) else { throw StripeError.invalidSourceType }
        switch rawType {
        case .card: self = .card(amount: amount)
        }
    }
    
    public var rawType: String {
        switch self {
        case .card(amount: _): return RawSourceType.card.rawValue
        }
    }
    
    public var amount: Int {
        switch self {
        case .card(amount: let amount): return amount
        }
    }
    
    public var dictionaryType: [String: Int] {
        switch self {
        case .card(amount: let amount): return [RawSourceType.card.rawValue: amount]
        }
    }
}
