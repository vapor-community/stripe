//
//  RefundItem.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor


public final class RefundItem: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var amount: Int?
    public private(set) var balanceTransactionId: String?
    public private(set) var charge: String?
    public private(set) var created: Date?
    public private(set) var currency: StripeCurrency?
    public private(set) var description: String?
    public private(set) var metadata: Node?
    public private(set) var reason: RefundReason?
    public private(set) var receiptNumber: String?
    public private(set) var status: StripeStatus?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.amount = try node.get("amount")
        self.balanceTransactionId = try node.get("balance_transaction")
        self.charge = try node.get("charge")
        self.created = try node.get("created")
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        self.description = try node.get("description")
        self.metadata = try node.get("metadata")
        if let reason = node["reason"]?.string {
            self.reason = RefundReason(rawValue: reason)
        }
        self.receiptNumber = try node.get("receipt_number")
        if let status = node["status"]?.string {
            self.status = StripeStatus(rawValue: status)
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "id": self.id,
            "object": self.object,
            "amount": self.amount,
            "balance_transaction": self.balanceTransactionId,
            "charge": self.charge ,
            "created": self.created,
            "currency": self.currency?.rawValue,
            "description": self.description,
            "metadata": self.metadata,
            "reason": self.reason?.rawValue,
            "receipt_number": self.receiptNumber,
            "status": self.status?.rawValue
        ]
        return try Node(node: object)
    }
}
