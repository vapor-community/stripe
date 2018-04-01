//
//  Products.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Foundation

/**
 Product object
 https://stripe.com/docs/api#products
 */

public protocol Product {
    associatedtype L: List
    associatedtype PD: PackageDimensions
    
    var id: String? { get }
    var object: String? { get }
    var active: Bool? { get }
    var attributes: [String]? { get }
    var caption: String? { get }
    var created: Date? { get }
    var deactivateOn: [String]? { get }
    var description: String? { get }
    var images: [String]? { get }
    var livemode: Bool? { get }
    var metadata: [String: String]? { get }
    var name: String? { get }
    var packageDimensions: PD? { get }
    var shippable: Bool? { get }
    var skus: L? { get }
    var statementDescriptor: String? { get }
    var type: String? { get }
    var updated: Date? { get }
    var url: String? { get }
}

public struct StripeProduct: Product, StripeModel {
    public var id: String?
    public var object: String?
    public var active: Bool?
    public var attributes: [String]?
    public var caption: String?
    public var created: Date?
    public var deactivateOn: [String]?
    public var description: String?
    public var images: [String]?
    public var livemode: Bool?
    public var metadata: [String : String]?
    public var name: String?
    public var packageDimensions: StripePackageDimensions?
    public var shippable: Bool?
    public var skus: SKUList?
    public var statementDescriptor: String?
    public var type: String?
    public var updated: Date?
    public var url: String?
    
    public enum CodingKeys: CodingKey, String {
        case id
        case object
        case active
        case attributes
        case caption
        case created
        case deactivateOn = "deactivate_on"
        case description
        case images
        case livemode
        case metadata
        case name
        case packageDimensions = "package_dimensions"
        case shippable
        case skus
        case statementDescriptor = "statement_descriptor"
        case type
        case updated
        case url
    }
}
