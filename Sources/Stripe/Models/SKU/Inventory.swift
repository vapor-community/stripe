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

public struct StripeInventory: StripeModel {
    public var quantity: Int?
    public var type: InventoryType?
    public var value: InventoryTypeValue?
}
