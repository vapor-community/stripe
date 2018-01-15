//
//  PackageDimensions.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/22/17.
//
//

import Foundation

/**
 Package Dimensions
 https://stripe.com/docs/api/curl#product_object-package_dimensions
 */

public protocol PackageDimensions {
    var height: Decimal? { get }
    var length: Decimal? { get }
    var weight: Decimal? { get }
    var width: Decimal? { get }
}

public struct StripePackageDimensions: PackageDimensions, StripeModelProtocol {
    public var height: Decimal?
    public var length: Decimal?
    public var weight: Decimal?
    public var width: Decimal?
}
