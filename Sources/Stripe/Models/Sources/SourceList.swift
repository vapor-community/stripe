//
//  SourceList.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//

import Foundation
import Vapor


public final class SourceList: StripeModelProtocol {
    
    public private(set) var object: String?
    public private(set) var url: String?
    public private(set) var hasMore: Bool?
    public private(set) var items: [Node]?
    public private(set) var cardSources: [Card] = []
    public private(set) var bankSources: [BankAccount] = []
    
    public init(node: Node) throws {
        self.object = try node.get("object")
        self.url = try node.get("url")
        self.hasMore = try node.get("has_more")
        self.items = try node.get("data")
        
        // Seperate different type of accounts to make it easier to work with.
        for item in items ?? [] {
            
            if let object = item["object"]?.string {
                if object == "bank_account" {
                    let bank = try BankAccount(node: item)
                    bankSources.append(bank)
                }
            }
            
            if let object = item["object"]?.string {
                if object == "card" {
                    cardSources.append(try Card(node: item))
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
