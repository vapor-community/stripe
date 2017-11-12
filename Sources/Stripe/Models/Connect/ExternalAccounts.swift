//
//  ExternalAccounts.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/8/17.
//
//

import Foundation
import Vapor

open class ExternalAccounts: StripeModelProtocol {
    
    public private(set) var object: String?
    public private(set) var url: String?
    public private(set) var hasMore: Bool?
    public private(set) var items: [Node]?
    public private(set) var cardAccounts: [Card] = []
    public private(set) var bankAccounts: [BankAccount] = []
    
    public required init(node: Node) throws {
        self.object = try node.get("object")
        self.url = try node.get("url")
        self.hasMore = try node.get("has_more")
        self.items = try node.get("data")
        
        // Seperate different type of accounts to make it easier to work with.
        for item in items ?? [] {
            
            if let object = item["object"]?.string {
                if object == "bank_account" {
                    let bank = try BankAccount(node: item)
                    bankAccounts.append(bank)
                }
            }
            
            if let object = item["object"]?.string {
                if object == "card" {
                    cardAccounts.append(try Card(node: item))
                }
            }
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "object": self.object,
            "url": self.url,
            "has_more": self.hasMore,
            "data": self.items
        ]
        return try Node(node: object)
    }
}
