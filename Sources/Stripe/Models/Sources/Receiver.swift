//
//  Receiver.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

/**
 Receiver object
 https://stripe.com/docs/api/curl#source_object-receiver
 */

public protocol Receiver {
    var address: String? { get }
    var amountCharged: Int? { get }
    var amountReceived: Int? { get }
    var amountReturned: Int? { get }
    var refundMethod: String? { get }
    var refundStatus: String? { get }
}

public struct StripeReceiver: Receiver, StripeModelProtocol {
    
    public var address: String?
    public var amountCharged: Int?
    public var amountReceived: Int?
    public var amountReturned: Int?
    public var refundMethod: String?
    public var refundStatus: String?
    
    enum CodingKeys: String, CodingKey {
        case address
        case amountCharged = "amount_charged"
        case amountReceived = "amount_received"
        case amountReturned = "amount_returned"
        case refundMethod = "refund_attributes_method"
        case refundStatus = "refund_attributes_status"
    }
}
