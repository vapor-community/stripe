//
//  Charge.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor
import Helpers

/**
 Charge Model
 https://stripe.com/docs/api/curl#charge_object
 */
public final class Charge: StripeModelProtocol {
    
    public let id: String
    public let object: String
    public let amount: Int
    public let amountRefunded: Int
    public let application: String?
    public let applicationFee: Int?
    public let balanceTransactionId: String
    public let isCaptured: Bool
    public let created: Date
    public let customerId: String?
    public let description: String?
    public let destination: String?
    public let failureCode: Int?
    public let failureMessage: String?
    public let invoiceId: String?
    public let isLiveMode: Bool
    public let isPaid: Bool
    public let isRefunded: Bool
    public let review: String?
    public let sourceTransfer: String?
    public let statementDescriptor: String?
    public let transferGroup: String?

    public private(set) var currency: StripeCurrency?
    public private(set) var fraud: FraudDetails?
    public private(set) var outcome: Outcome?
    public private(set) var refunds: Refund?
    public private(set) var status: StripeStatus?
    public private(set) var shippingLabel: ShippingLabel?

    public private(set) var metadata: Node?

    public private(set) var card: Card?
    public private(set) var source: Source?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.amount = try node.get("amount")
        self.amountRefunded = try node.get("amount_refunded")
        self.application = try node.get("application")
        self.applicationFee = try node.get("application_fee")
        self.balanceTransactionId = try node.get("balance_transaction")
        self.isCaptured = try node.get("captured")
        self.created = try node.get("created")
        self.customerId = try node.get("customer")
        self.description = try node.get("description")
        self.destination = try node.get("destination")
        self.failureCode = try node.get("failure_code")
        self.failureMessage = try node.get("failure_message")
        self.invoiceId = try node.get("invoice")
        self.isLiveMode = try node.get("livemode")
        self.isPaid = try node.get("paid")
        self.isRefunded = try node.get("refunded")
        self.review = try node.get("review")
        self.sourceTransfer = try node.get("source_transfer")
        self.statementDescriptor = try node.get("statement_descriptor")
        self.transferGroup = try node.get("transfer_group")

        self.currency = try StripeCurrency(rawValue: node.get("currency"))
        self.fraud = try node.get("fraud_details")
        self.outcome = try node.get("outcome")
        self.refunds = try node.get("refunds")
        self.status = try StripeStatus(rawValue: node.get("status"))
        
        if let shippingLabel: [String: Any]? = try node.get("shipping") {
            if let _ = shippingLabel {
                self.shippingLabel = try node.get("shipping")
            }
        }
        
        self.metadata = try node.get("metadata")
        
        // We have to determine if it's a card or a source item
        if let sourceNode: Node = try node.get("source") {
            if let object = sourceNode["object"]?.string, object == "card" {
                self.card = try node.get("source")
            } else if let object = sourceNode["object"]?.string, object == "source" {
                self.source = try node.get("source")
            }
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        var object: [String : Any?] = [
            "id": self.id,
            "object": self.object,
            "amount": self.amount,
            "amount_refunded": self.amountRefunded,
            "application": self.application,
            "application_fee": self.applicationFee,
            "balance_transaction": self.balanceTransactionId,
            "captured": self.isCaptured,
            "created": self.created,
            "currency": self.currency,
            "customer": self.customerId,
            "description": self.description,
            "destination": self.destination,
            "failure_code": self.failureCode,
            "failure_message": self.failureMessage,
            "fraud_details": self.fraud,
            "invoice": self.invoiceId,
            "livemode": self.isLiveMode,
            "metadata": self.metadata,
            "outcome": self.outcome,
            "paid": self.isPaid,
            "refunded": self.isRefunded,
            "refunds": self.refunds,
            "review": self.review,
            "shipping": self.shippingLabel,
            "source_transfer": self.sourceTransfer,
            "statement_descriptor": self.statementDescriptor,
            "status": self.status?.rawValue,
            "transfer_group": self.transferGroup
        ]
        
        if let source = self.source {
            object["source"] = source
        } else if let card = self.card {
            object["source"] = card
        }
        return try Node(node: object)
    }
    
}
