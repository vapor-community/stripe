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

public protocol SKU {
    associatedtype PD: PackageDimensions
    associatedtype I: Inventory
    
    var id: String? { get }
    var object: String? { get }
    var active: Bool? { get }
    var attributes: [String: String]? { get }
    var created: Date? { get }
    var currency: StripeCurrency? { get }
    var image: String? { get }
    var inventory: I? { get }
    var isLive: Bool? { get }
    var metadata: [String: String]? { get }
    var packageDimensions: PD? { get }
    var price: Int? { get }
    var productId: String? { get }
    var updated: Date? { get }
}

public struct StripeSKU: SKU, StripeModelProtocol {
    public var id: String?
    public var object: String?
    public var active: Bool?
    public var attributes: [String: String]?
    public var created: Date?
    public var currency: StripeCurrency?
    public var image: String?
    public var inventory: StripeInventory?
    public var isLive: Bool?
    public var metadata: [String: String]?
    public var packageDimensions: StripePackageDimensions?
    public var price: Int?
    public var productId: String?
    public var updated: Date?
    
    enum CodngKeys: String, CodingKey {
        case id
        case object
        case active
        case attributes
        case created
        case currency
        case image
        case inventory
        case isLive = "livemode"
        case metadata
        case packageDimensions = "package_dimensions"
        case price
        case productId = "product"
        case updated
    }
}
