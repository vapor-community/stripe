//
//  OrderReturn.swift
//  Stripe
//
//  Created by Andrew Edwards on 8/23/17.
//
//

import Foundation

/**
 OrderReturn object
 https://stripe.com/docs/api#order_return_object
 */

public protocol OrderReturn {
    associatedtype OI: OrderItem
    
    var id: String? { get }
    var object: String? { get }
    var amount: Int? { get }
    var created: Date? { get }
    var currency: StripeCurrency? { get }
    var items: [OI]? { get }
    var isLive: Bool? { get }
    var order: String? { get }
    var refundId: String? { get }
}

public struct StripeOrderReturn: OrderReturn, StripeModelProtocol {
    public var id: String?
    public var object: String?
    public var amount: Int?
    public var created: Date?
    public var currency: StripeCurrency?
    public var items: [StripeOrderItem]?
    public var isLive: Bool?
    public var order: String?
    public var refundId: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case object
        case amount
        case created
        case currency
        case items
        case isLive = "livemode"
        case order
        case refundId = "refund"
    }
}
