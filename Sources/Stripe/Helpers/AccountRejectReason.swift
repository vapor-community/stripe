//
//  AccountRejectReason.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/9/17.
//
//

public enum AccountRejectReason: String, Codable {
    case fraud
    case termsOfService
    case other
    
    enum CodingKeys: String, CodingKey {
        case fraud
        case termsOfService = "terms_of_service"
        case other
    }
}
