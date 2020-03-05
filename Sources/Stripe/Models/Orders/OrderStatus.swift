//
//  OrderStatus.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

public enum OrderStatus: String, Codable {
    case created
    case paid
    case canceled
    case fulfilled
    case returned
}
