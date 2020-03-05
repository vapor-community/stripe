//
//  Order.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation

/**
 Order object
 https://stripe.com/docs/api#order_object
 */

public struct StripeOrder: StripeModel {
    public var id: String
    public var object: String
    public var amount: Int?
    public var amountReturned: Int?
    public var application: String?
    public var applicationFee: Int?
    public var charge: String?
    public var created: Date?
    public var currency: StripeCurrency?
    public var customer: String?
    public var email: String?
    public var externalCouponCode: String?
    public var items: [StripeOrderItem]?
    public var livemode: Bool?
    public var metadata: [String: String]
    public var returns: OrderReturnList?
    public var selectedShippingMethod: String?
    public var shipping: ShippingLabel?
    public var shippingMethods: [StripeShippingMethod]?
    public var status: OrderStatus?
    public var statusTransitions: StripeOrderStatusTransitions?
    public var updated: Date?
    public var upstreamId: String?
    
    public enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case amountReturned = "amount_returned"
        case application
        case applicationFee = "application_fee"
        case charge
        case created
        case currency
        case customer
        case email
        case externalCouponCode = "external_coupon_code"
        case items
        case livemode
        case metadata
        case returns
        case selectedShippingMethod = "selected_shipping_method"
        case shipping
        case shippingMethods = "shipping_methods"
        case status
        case statusTransitions = "status_transitions"
        case updated
        case upstreamId = "upstream_id"
    }
}
