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

public protocol Order {
    associatedtype O: OrderItem
    associatedtype R: OrderReturn
    associatedtype S: Shipping
    associatedtype SM: ShippingMethod
    associatedtype SS: OrderStatusTransitions
    
    var id: String? { get }
    var object: String? { get }
    var amount: Int? { get }
    var amountReturned: Int? { get }
    var application: String? { get }
    var applicationFee: Int? { get }
    var charge: String? { get }
    var created: Date? { get }
    var currency: StripeCurrency? { get }
    var customer: String? { get }
    var email: String? { get }
    var externalCouponCode: String? { get }
    var items: [O]? { get }
    var livemode: Bool? { get }
    var metadata: [String: String]? { get }
    var returns: [R]? { get }
    var selectedShippingMethod: String? { get }
    var shipping: S? { get }
    var shippingMethods: [SM]? { get }
    var status: OrderStatus? { get }
    var statusTransitions: SS? { get }
    var updated: Date? { get }
    var upstreamId: String? { get }
}

public struct StripeOrder: Order, StripeModel {
    public var id: String?
    public var object: String?
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
    public var metadata: [String: String]?
    public var returns: [StripeOrderReturn]?
    public var selectedShippingMethod: String?
    public var shipping: ShippingLabel?
    public var shippingMethods: [StripeShippingMethod]?
    public var status: OrderStatus?
    public var statusTransitions: StripeOrderStatusTransitions?
    public var updated: Date?
    public var upstreamId: String?
}
