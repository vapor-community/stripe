//
//  OrderItemType.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation

public enum OrderItemType: String {
    case sku = "sku"
    case tax = "tax"
    case shipping = "shipping"
    case discount = "discount"
    case none = "none"
}
