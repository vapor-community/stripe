//
//  OrderStatus.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation

public enum OrderStatus: String {
    case created = "created"
    case paid = "paid"
    case canceled = "canceled"
    case fulfilled = "fulfilled"
    case returned = "returned"
}
