//
//  Product.swift
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

public struct StripeProduct: StripeModel {
    public var id: String
    public var object: String
    public var active: Bool?
    public var attributes: [String]?
    public var caption: String?
    public var created: Date?
    public var deactivateOn: [String]?
    public var description: String?
    public var images: [String]?
    public var livemode: Bool?
    public var metadata: [String: String]
    public var name: String?
    public var packageDimensions: StripePackageDimensions?
    public var shippable: Bool?
    public var statementDescriptor: String?
    public var type: ProductType?
    public var updated: Date?
    public var url: String?
    
    public enum CodingKeys: String, CodingKey {
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
        case statementDescriptor = "statement_descriptor"
        case type
        case updated
        case url
    }
}
