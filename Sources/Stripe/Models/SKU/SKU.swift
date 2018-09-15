//
//  SKU.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Foundation

/**
 SKU object
 https://stripe.com/docs/api#skus
 */

public struct StripeSKU: StripeModel {
    public var id: String
    public var object: String
    public var active: Bool?
    public var attributes: [String: String]?
    public var created: Date?
    public var currency: StripeCurrency?
    public var image: String?
    public var inventory: StripeInventory?
    public var livemode: Bool?
    public var metadata: [String: String]
    public var packageDimensions: StripePackageDimensions?
    public var price: Int?
    public var product: String?
    public var updated: Date?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case active
        case attributes
        case created
        case currency
        case image
        case inventory
        case livemode
        case metadata
        case packageDimensions = "package_dimensions"
        case price
        case product
        case updated
    }
}
