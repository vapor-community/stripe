//
//  PaymentSource.swift
//  Stripe
//
//  Created by Nicolas Bachschmidt on 2018-08-09.
//

/**
 Payment Source objects
 https://stripe.com/docs/api#customer_bank_account_object
 https://stripe.com/docs/api#card_object
 https://stripe.com/docs/api#source_object
 */

public enum StripePaymentSource: StripeModel {
    case bankAccount(StripeBankAccount)
    case card(StripeCard)
    case source(StripeSource)
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let object = try container.decode(String.self, forKey: .object)
        switch object {
        case "bank_account":
            self = try .bankAccount(StripeBankAccount(from: decoder))
        case "card":
            self = try .card(StripeCard(from: decoder))
        case "source":
            self = try .source(StripeSource(from: decoder))
        default:
            throw DecodingError.dataCorruptedError(
                forKey: CodingKeys.object,
                in: container,
                debugDescription: "Unknown payment source \"\(object)\""
            )
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        switch self {
        case let .bankAccount(bankAccount):
            try bankAccount.encode(to: encoder)
        case let .card(card):
            try card.encode(to: encoder)
        case let .source(source):
            try source.encode(to: encoder)
        }
    }
    
    public enum CodingKeys: String, CodingKey {
        case object
    }
}

extension StripePaymentSource {
    public var bankAccount: StripeBankAccount? {
        guard case let .bankAccount(bankAccount) = self else {
            return nil
        }
        return bankAccount
    }
    
    public var card: StripeCard? {
        guard case let .card(card) = self else {
            return nil
        }
        return card
    }
    
    public var source: StripeSource? {
        guard case let .source(source) = self else {
            return nil
        }
        return source
    }
    
    public var id: String {
        switch self {
        case let .bankAccount(bankAccount):
            return bankAccount.id
        case let .card(card):
            return card.id
        case let .source(source):
            return source.id
        }
    }
    
    public var object: String {
        switch self {
        case let .bankAccount(bankAccount):
            return bankAccount.object
        case let .card(card):
            return card.object
        case let .source(source):
            return source.object
        }
    }
}
