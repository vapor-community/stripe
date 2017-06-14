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
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var amount: Int?
    public private(set) var amountRefunded: Int?
    public private(set) var application: String?
    public private(set) var applicationFee: String?
    public private(set) var balanceTransactionId: String?
    public private(set) var isCaptured: Bool?
    public private(set) var created: Date?
    public private(set) var currency: StripeCurrency?
    public private(set) var customerId: String?
    public private(set) var destination: String?
    public private(set) var dispute: String?
    public private(set) var failureCode: String?
    public private(set) var failureMessage: String?
    public private(set) var invoiceId: String?
    public private(set) var isLiveMode: Bool?
    public private(set) var onBehalfOf: String?
    public private(set) var order: String?
    public private(set) var outcome: Outcome?
    public private(set) var isPaid: Bool?
    public private(set) var recieptNumber: String?
    public private(set) var isRefunded: Bool?
    public private(set) var refunds: Refund?
    public private(set) var review: String?
    public private(set) var source: Source?
    public private(set) var card: Card?
    public private(set) var sourceTransfer: String?
    public private(set) var statementDescriptor: String?
    public private(set) var status: StripeStatus?
    public private(set) var transfer: String?
    
    /**
     Only these values are mutable/updatable.
     https://stripe.com/docs/api/curl#update_charge
     */
    
    public private(set) var description: String?
    public private(set) var fraud: FraudDetails?
    public private(set) var metadata: Node?
    public private(set) var receiptEmail: String?
    public private(set) var shippingLabel: ShippingLabel?
    public private(set) var transferGroup: String?
    
    public init() {}
    
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
        self.dispute = try node.get("dispute")
        self.failureCode = try node.get("failure_code")
        self.failureMessage = try node.get("failure_message")
        self.invoiceId = try node.get("invoice")
        self.isLiveMode = try node.get("livemode")
        self.onBehalfOf = try node.get("on_behalf_of")
        self.isPaid = try node.get("paid")
        self.recieptNumber = try node.get("receipt_number")
        self.isRefunded = try node.get("refunded")
        self.review = try node.get("review")
        self.sourceTransfer = try node.get("source_transfer")
        self.statementDescriptor = try node.get("statement_descriptor")
        self.transferGroup = try node.get("transfer_group")
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        self.fraud = try node.get("fraud_details")
        self.outcome = try node.get("outcome")
        self.refunds = try node.get("refunds")
        if let status  = node["status"]?.string {
            self.status = StripeStatus(rawValue: status)
        }
        self.transfer = try node.get("transfer")
        self.receiptEmail = try node.get("receipt_email")
        if let _ = node["shipping"]?.object {
            self.shippingLabel = try node.get("shipping")
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
            "dispute": self.dispute,
            "failure_code": self.failureCode,
            "failure_message": self.failureMessage,
            "fraud_details": self.fraud,
            "invoice": self.invoiceId,
            "livemode": self.isLiveMode,
            "on_behalf_of": self.onBehalfOf,
            "metadata": self.metadata,
            "outcome": self.outcome,
            "paid": self.isPaid,
            "receipt_number": self.recieptNumber,
            "refunded": self.isRefunded,
            "refunds": self.refunds,
            "review": self.review,
            "shipping": self.shippingLabel,
            "source_transfer": self.sourceTransfer,
            "statement_descriptor": self.statementDescriptor,
            "status": self.status?.rawValue,
            "transfer": self.transfer,
            "receipt_email": self.receiptEmail,
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
