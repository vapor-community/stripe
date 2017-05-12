//
//  BankAccount.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/12/17.
//
//

import Foundation
import Vapor
import Helpers

/*
 https://stripe.com/docs/api/curl#create_bank_account_token
*/
public final class BankAccount: StripeModelProtocol {
    
    public let id: String
    public let object: String
    public let accountHolderName: String?
    public let accountHolderType: String?
    public let name: String?
    public let country: String?
    public let fingerprint: String?
    public let last4: String?
    public let routingNumber: String?
    public let status: String?
    
    public let currency: StripeCurrency?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.accountHolderName = try node.get("account_holder_name")
        self.accountHolderType = try node.get("account_holder_type")
        self.name = try node.get("bank_name")
        self.country = try node.get("country")
        self.fingerprint = try node.get("fingerprint")
        self.last4 = try node.get("last4")
        self.routingNumber = try node.get("routing_number")
        self.status = try node.get("status")
        self.currency = try StripeCurrency(rawValue: node.get("currency"))
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "id": self.id,
            "object": self.object,
            "account_holder_name": self.accountHolderName,
            "account_holder_type": self.accountHolderType,
            "bank_name": self.name,
            "country": self.country,
            "fingerprint": self.fingerprint,
            "last4": self.last4,
            "routing_number": self.routingNumber,
            "status": self.status,
            "currency": self.currency?.rawValue
        ]
        return try Node(node: object)
    }
    
}
