//
//  Invoice.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/4/17.
//
//

import Foundation
import Vapor

/**
 Invoice Model
 https://stripe.com/docs/api#invoice_object
 */
public final class Invoice: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var amountDue: Int
    public private(set) var applicationFee: Int?
    public private(set) var attemptCount: Int
    public private(set) var hasAttemptedCharge: Bool
    public private(set) var charge: String?
    public private(set) var isClosed: Bool
    public private(set) var customer: String?
    public private(set) var date: Date?
    public private(set) var description: String?
    public private(set) var discount: String?
    public private(set) var endingBalance: Int?
    public private(set) var isForgiven: Bool
    public private(set) var isLiveMode: Bool
    public private(set) var isPaid: Bool
    
    public private(set) var nextPaymentAttempt: Date?
    public private(set) var periodStart: Date?
    public private(set) var periodEnd: Date?
    
    public private(set) var receiptNumber: String?
    public private(set) var startingBalance: Int?
    
    public private(set) var statementDescriptor: String?
    public private(set) var subscription: String?
    
    public private(set) var subtotal: Int
    public private(set) var total: Int
    
    public private(set) var tax: Int?
    public private(set) var taxPercent: Int?
    
    public private(set) var webhooksDeliveredAt: Date?
    
    public private(set) var metadata: Node?
    
    public private(set) var lines: [InvoiceLineItem]?
    public private(set) var currency: StripeCurrency?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.amountDue = try node.get("amount_due")
        self.applicationFee = try node.get("application_fee")
        self.attemptCount = try node.get("attempt_count")
        self.hasAttemptedCharge = try node.get("attempted")
        self.charge = try node.get("charge")
        self.isClosed = try node.get("closed")
        self.customer = try node.get("customer")
        self.date = try node.get("date")
        self.description = try node.get("description")
        self.discount = try node.get("discount")
        self.endingBalance = try node.get("ending_balance")
        self.isForgiven = try node.get("forgiven")
        self.isLiveMode = try node.get("livemode")
        self.isPaid = try node.get("paid")
        self.nextPaymentAttempt = try node.get("next_payment_attempt")
        self.periodStart = try node.get("period_start")
        self.periodEnd = try node.get("period_end")
        self.receiptNumber = try node.get("receipt_number")
        self.startingBalance = try node.get("starting_balance")
        self.statementDescriptor = try node.get("statement_descriptor")
        self.subscription = try node.get("subscription")
        self.subtotal = try node.get("subtotal")
        self.total = try node.get("total")
        self.tax = try node.get("tax")
        self.taxPercent = try node.get("tax_percent")
        
        self.webhooksDeliveredAt = try node.get("webhooks_delivered_at")
        
        self.metadata = try node.get("metadata")
        
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        
        if let lines = node["lines"]?.object, let data = lines["data"]?.array {
            self.lines = try data.map({ try InvoiceLineItem(node: $0) })
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String: Any?] = [
            "id": self.id,
            "object": self.object,
            "amount_due": self.amountDue,
            "application_fee": self.applicationFee,
            "attempt_count": self.attemptCount,
            "attempted": self.hasAttemptedCharge,
            "charge": self.charge,
            "closed": self.isClosed,
            "customer": self.customer,
            "date": self.date,
            "description": self.description,
            "discount": self.discount,
            "ending_balance": self.endingBalance,
            "forgiven": self.isForgiven,
            "livemode": self.isLiveMode,
            "paid": self.isPaid,
            "next_payment_attempt": self.nextPaymentAttempt,
            "period_start": self.periodStart,
            "period_end": self.periodEnd,
            "receipt_number": self.receiptNumber,
            "starting_balance": self.startingBalance,
            "statement_descriptor": self.statementDescriptor,
            "subscription": self.subscription,
            "subtotal": self.subtotal,
            "total": self.total,
            "tax": self.tax,
            "tax_percent": self.taxPercent,
            "webhooks_delivered_at": self.webhooksDeliveredAt,
            
            "metadata": self.metadata,
            
            "currency": self.currency?.rawValue
        ]
        
        return try Node(node: object)
    }
}

public final class InvoiceList: StripeModelProtocol {
    
    public private(set) var object: String?
    public private(set) var hasMore: Bool?
    public private(set) var items: [Invoice]?
    
    public init(node: Node) throws {
        self.object = try node.get("object")
        self.hasMore = try node.get("has_more")
        self.items = try node.get("data")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "object": self.object,
            "has_more": self.hasMore,
            "data": self.items
        ]
        return try Node(node: object)
    }
}
