//
//  Source.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/15/17.
//
//

import Foundation
import Vapor
import Helpers

/*
 Source Model
 https://stripe.com/docs/api/curl#source_object
 */
public final class Source: StripeModelProtocol {
    
    public let id: String
    public let object: String
    public let amount: Int
    public let clientSecret: String
    public let created: Date
    public let currency: StripeCurrency?
    public let flow: String
    public let isLive: Bool
    public let status: StripeStatus?
    public let type: ActionType?
    public let usage: String
    public let metadata: [String : Any]
    
    public init(node: Node) throws {
        
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        return try Node(node: [:])
    }
    
}
