//
//  DeliveryEstimateType.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation

// https://stripe.com/docs/api/curl#order_object-shipping_methods-delivery_estimate-type
public enum DeliveryEstimateType: String, Codable {
    case range
    case exact
}
