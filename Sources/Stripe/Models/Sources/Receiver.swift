//
//  Receiver.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import Foundation
import Vapor


public final class Receiver: StripeModelProtocol {
    
    public private(set) var address: String?
    public private(set) var amountCharged: Int?
    public private(set) var amountReceived: Int?
    public private(set) var amountReturned: Int?
    public private(set) var refundMethod: String?
    public private(set) var refundStatus: String?
    
    public init(node: Node) throws {
        self.address = try node.get("address")
        self.amountCharged = try node.get("amount_charged")
        self.amountReceived = try node.get("amount_received")
        self.amountReturned = try node.get("amount_returned")
        self.refundMethod = try node.get("refund_attributes_method")
        self.refundStatus = try node.get("refund_attributes_status")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "address": self.address,
            "amount_charged": self.amountCharged,
            "amount_received": self.amountReceived,
            "amount_returned": self.amountReturned,
            "refund_attributes_method": self.refundMethod,
            "refund_attributes_status": self.refundStatus
        ]
        return try Node(node: object)
    }
}
