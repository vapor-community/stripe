//
//  Transaction.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/14/17.
//
//

import Node
import Helpers

public class Transfer: StripeModelProtocol {
    
    public let currency: StripeCurrency
    public let amount: Int
    public private(set) var sourceTypes = [SourceType]()
    
    public required init(node: Node) throws {
        self.currency = try StripeCurrency(rawValue: node.get("currency"))!
        self.amount = try node.get("amount")
        let items: [String : Int] = try node.get("source_types")
        self.sourceTypes = try items.map { try SourceType(type: $0.key, amount: $0.value) }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let types = self.sourceTypes.flatMap { $0 }.reduce([String : Int]()) { dictionary, item in
            var dictionary = dictionary
            dictionary.updateValue(item.amount, forKey: item.rawType)
            return dictionary
        }
        
        return try Node(node: [
            "currency": self.currency.rawValue,
            "amount": self.amount,
            "source_types": types
        ])
    }
    
}
