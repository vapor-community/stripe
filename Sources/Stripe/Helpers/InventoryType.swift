//
//  InventoryType.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

public enum InventoryType: String, Codable {
    case finite
    case bucket
    case infinite
    case unknown
}

public enum InventoryTypeValue: String, Codable {
    case inStock
    case limited
    case outOfStock
    case unknown
    
    enum Codingeys: String, CodingKey {
        case inStock = "in_stock"
        case limited
        case outOfStock = "out_of_stock"
        case unknown
    }
}
