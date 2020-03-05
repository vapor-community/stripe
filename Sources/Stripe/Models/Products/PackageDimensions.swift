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

public struct StripePackageDimensions: StripeModel {
    public var height: Decimal?
    public var length: Decimal?
    public var weight: Decimal?
    public var width: Decimal?
}
