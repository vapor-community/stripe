//
//  Orders.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation
import Vapor


/**
 Order object
 https://stripe.com/docs/api#order_object
 */

public final class Order: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var amount: Int?
    public private(set) var amountReturned: Int?
    public private(set) var application: String?
    public private(set) var applicationFee: Int?
    public private(set) var charge: String?
    public private(set) var created: Date?
    public private(set) var currency: StripeCurrency?
    public private(set) var customer: String?
    public private(set) var email: String?
    public private(set) var externalCouponCode: String?
    public private(set) var items: [OrderItem]?
    public private(set) var isLive: Bool?
    public private(set) var metadata: Node?
    public private(set) var returns: [OrderReturn]?
    public private(set) var selectedShippingMethod: String?
    public private(set) var shipping: ShippingLabel?
    public private(set) var shippingMethods: [ShippingMethod]?
    public private(set) var status: OrderStatus?
    public private(set) var statusTransitions: StatusTransitions?
    public private(set) var updated: Date?
    public private(set) var upstreamId: String?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.amount = try node.get("amount")
        self.amountReturned = try node.get("amount_returned")
        self.application = try node.get("application")
        self.applicationFee = try node.get("application_fee")
        self.charge = try node.get("charge")
        self.created = try node.get("created")
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        self.customer = try node.get("customer")
        self.email = try node.get("email")
        self.externalCouponCode = try node.get("external_coupon_code")
        self.items = try node.get("items")
        self.isLive = try node.get("livemode")
        self.metadata = try node.get("metadata")
        self.returns = try node.get("returns")
        self.selectedShippingMethod = try node.get("selected_shipping_method")
        self.shipping = try node.get("shipping")
        self.shippingMethods = try node.get("shipping_methods")
        if let status = node["status"]?.string {
            self.status = OrderStatus(rawValue: status)
        }
        self.statusTransitions = try node.get("status_transitions")
        self.updated = try node.get("updated")
        self.upstreamId = try node.get("upstream_id")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        
        let object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "amount": self.amount,
            "amount_returned": self.amountReturned,
            "application": self.application,
            "application_fee": self.applicationFee,
            "charge": self.charge,
            "created": self.created,
            "currency": self.currency?.rawValue,
            "customer": self.customer,
            "email": self.email,
            "external_coupon_code": self.externalCouponCode,
            "items": self.items,
            "livemode": self.isLive,
            "metadata": self.metadata,
            "selected_shipping_method": self.selectedShippingMethod,
            "shipping": self.shipping,
            "shipping_methods": self.shippingMethods,
            "status": self.status,
            "status_transitions": self.statusTransitions,
            "updated": self.updated,
            "upstream_id": self.upstreamId
        ]
        return try Node(node: object)
    }
}
