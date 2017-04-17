//
//  Receiver.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/16/17.
//
//

import Foundation
import Vapor
import Helpers

public final class Receiver: StripeModelProtocol {
    
    public let address: String?
    public let amountCharged: Int
    public let amountReceived: Int
    public let amountReturned: Int
    public let refundMethod: String?
    public let refundStatus: String?
    
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
