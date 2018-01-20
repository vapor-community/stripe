//
//  Inventory.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

/**
 Inventory object
 https://stripe.com/docs/api/curl#sku_object-inventory
 */

public protocol Inventory {
    var quantity: Int? { get }
    var type: InventoryType? { get }
    var value: InventoryTypeValue? { get }
}

public struct StripeInventory: Inventory, StripeModel {
    public var quantity: Int?
    public var type: InventoryType?
    public var value: InventoryTypeValue?
}
