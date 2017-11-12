//
//  BankAccount.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/12/17.
//
//

import Foundation
import Vapor

/**
 Bank Account Model
 https://stripe.com/docs/api/curl#customer_bank_account_object
*/
open class BankAccount: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var account: String?
    public private(set) var name: String?
    public private(set) var country: String?
    public private(set) var fingerprint: String?
    public private(set) var last4: String?
    public private(set) var routingNumber: String?
    public private(set) var status: String?
    public private(set) var customer: String?
    public private(set) var defaultForCurrency: Bool?
    public private(set) var currency: StripeCurrency?
    
    /**
     Only these values are mutable/updatable.
     https://stripe.com/docs/api/curl#customer_update_bank_account
     */
    
    public private(set) var accountHolderName: String?
    public private(set) var accountHolderType: String?
    public private(set) var metadata: Node?
    
    public required init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.account = try node.get("account")
        self.accountHolderName = try node.get("account_holder_name")
        self.accountHolderType = try node.get("account_holder_type")
        self.name = try node.get("bank_name")
        self.country = try node.get("country")
        self.fingerprint = try node.get("fingerprint")
        self.last4 = try node.get("last4")
        self.routingNumber = try node.get("routing_number")
        self.status = try node.get("status")
        self.customer = try node.get("customer")
        self.defaultForCurrency = try node.get("default_for_currency")
        if let currency = node["currency"]?.string {
             self.currency = StripeCurrency(rawValue: currency)
        }
        self.metadata = try node.get("metadata")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "id": self.id,
            "object": self.object,
            "account": self.account,
            "account_holder_name": self.accountHolderName,
            "account_holder_type": self.accountHolderType,
            "bank_name": self.name,
            "country": self.country,
            "fingerprint": self.fingerprint,
            "last4": self.last4,
            "routing_number": self.routingNumber,
            "status": self.status,
            "customer": self.customer,
            "default_for_currency": self.defaultForCurrency,
            "currency": self.currency?.rawValue,
            "metadata": self.metadata
        ]
        return try Node(node: object)
    }
}
