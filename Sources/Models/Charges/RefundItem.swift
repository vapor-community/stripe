//
//  RefundItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor
import Helpers

public enum RefundReason: String {
    case duplicate = "duplicate"
    case fraudulent = "fraudulent"
    case requestedByCustomer = "requested_by_customer"
}

public final class RefundItem: StripeModelProtocol {
    
    public let id: String
    public let object: String
    public let amount: Int
    public let balanceTransactionId: String?
    public let charge: String?
    public let created: Date
    public let currency: StripeCurrency?
    public let description: String
    public let metadata: [String : Any]?
    public let reason: RefundReason?
    public let receiptNumber: String
    public let status: StripeStatus?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.amount = try node.get("amount")
        self.balanceTransactionId = try node.get("balance_transaction")
        self.charge = try node.get("charge")
        self.created = try node.get("created")
        self.currency = try StripeCurrency(rawValue: node.get("currency"))
        self.description = try node.get("description")
        self.metadata = try node.get("metadata")
        self.reason = try RefundReason(rawValue: node.get("reason"))
        self.receiptNumber = try node.get("receipt_number")
        self.status = try StripeStatus(rawValue: node.get("status"))
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "id": self.id,
            "object": self.object,
            "amount": self.amount,
            "balance_transaction": self.balanceTransactionId ?? nil,
            "charge": self.charge ?? nil,
            "created": self.created,
            "currency": self.currency?.rawValue,
            "description": self.description,
            "metadata": self.metadata ?? nil,
            "reason": self.reason?.rawValue,
            "receipt_number": self.receiptNumber,
            "status": self.status?.rawValue
        ]
        return try Node(node: object)
    }
    
}
