//
//  BalanceTransfer.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/14/17.
//
//

import Node



/**
 Balance transfer is the body object of available array.
 https://stripe.com/docs/api/curl#balance_object
 */
public class BalanceTransfer: StripeModelProtocol {
    
    public private(set) var currency: StripeCurrency?
    public private(set) var amount: Int?
    public private(set) var sourceTypes: [SourceType: Int] = [:]
    
    public required init(node: Node) throws {
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        self.amount = try node.get("amount")
        
        let items: [String : Int] = try node.get("source_types")
        
        for item in items {
            sourceTypes[SourceType(rawValue: item.key) ?? .none] = item.value
        }
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let types = self.sourceTypes.flatMap { $0 }.reduce([String : Int]()) { dictionary, item in
            var dictionary = dictionary
            dictionary.updateValue(item.value, forKey: item.key.rawValue)
            return dictionary
        }
        
       let object: [String : Any?] = [
        "currency": self.currency?.rawValue,
        "amount": self.amount,
        "source_types": types
        ]
        return try Node(node: object)
    }
}
