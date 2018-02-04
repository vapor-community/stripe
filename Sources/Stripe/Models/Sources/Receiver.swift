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
    var refundAttributesMethod: String? { get }
    var refundAttributesStatus: String? { get }
}

public struct StripeReceiver: Receiver, StripeModel {
    public var address: String?
    public var amountCharged: Int?
    public var amountReceived: Int?
    public var amountReturned: Int?
    public var refundAttributesMethod: String?
    public var refundAttributesStatus: String?
}
