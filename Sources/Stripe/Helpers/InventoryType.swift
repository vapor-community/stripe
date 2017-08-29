//
//  InventoryType.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Foundation

public enum InventoryType: String {
    case finite = "finite"
    case bucket = "bucket"
    case infinite = "infinite"
    case unknown = "unknown"
}

public enum InventoryTypeValue: String {
    case inStock = "in_stock"
    case limited = "limited"
    case outOfStock = "out_of_stock"
    case unknown = "unknown"
}
