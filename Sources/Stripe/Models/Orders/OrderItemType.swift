//
//  OrderItemType.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

public enum OrderItemType: String, Codable {
    case sku
    case tax
    case shipping
    case discount
}
