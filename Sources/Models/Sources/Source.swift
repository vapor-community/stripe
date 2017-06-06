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

/**
 Source Model
 https://stripe.com/docs/api/curl#source_object
 */
public final class Source: StripeModelProtocol {
    
    public private(set) var id: String?
    public private(set) var object: String?
    public private(set) var amount: Int?
    public private(set) var clientSecret: String?
    public private(set) var codeVerificationStatus: String?
    public private(set) var attemptsRemaining: Int?
    public private(set) var created: Date?
    public private(set) var currency: StripeCurrency?
    public private(set) var flow: String?
    public private(set) var isLive: Bool?
    public private(set) var redirectReturnUrl: String?
    public private(set) var redirectStatus: String?
    public private(set) var redirectUrl: String?
    public private(set) var status: StripeStatus?
    public private(set) var type: SourceType?
    public private(set) var usage: String?
    public private(set) var reciever: Receiver?
    public private(set) var returnedSource: [String:[String: Node]]?
    
    /**
     Only these values are mutable/updatable.
     https://stripe.com/docs/api/curl#update_source
     */
    
    public private(set) var metadata: Node?
    public private(set) var owner: Owner?
    
    public init(node: Node) throws {
        self.id = try node.get("id")
        self.object = try node.get("object")
        self.amount = try node.get("amount")
        self.clientSecret = try node.get("client_secret")
        /// We can check for code verification dictionary here
        if let codeVerification = node["code_verification"]?.object {
            self.attemptsRemaining = codeVerification["attempts_remaining"]?.int
            self.codeVerificationStatus = codeVerification["status"]?.string
        }
        /// We can check for redirect dictionary here
        if let redirect = node["redirect"]?.object {
            self.redirectReturnUrl = redirect["return_url"]?.string
            self.redirectStatus = redirect["status"]?.string
            self.redirectUrl = redirect["url"]?.string
        }
        self.created = try node.get("created")
        if let currency = node["currency"]?.string {
            self.currency = StripeCurrency(rawValue: currency)
        }
        self.flow = try node.get("flow")
        self.isLive = try node.get("livemode")
        if let status = node["status"]?.string {
            self.status = StripeStatus(rawValue: status)
        }
        /// if we have a type we should have a body to parse
        if let type = node["type"]?.string {
            self.type = SourceType(rawValue: type)
            if let sourceTypeBody = node["\(type)"]?.object {
                var sourceBody: [String: Node] = [:]
                for (key,val) in sourceTypeBody {
                    sourceBody["\(key)"] = val
                }
                self.returnedSource = ["\(type)": sourceBody]
            }
        }
        self.usage = try node.get("usage")
        self.metadata = try node.get("metadata")
        self.owner = try node.get("owner")
        self.reciever = try node.get("receiver")
    }
    
    public func makeNode(in context: Context?) throws -> Node {
        let object: [String : Any?] = [
            "id": self.id,
            "object": self.object,
            "amount": self.amount,
            "client_secret": self.clientSecret,
            "created": self.created,
            "currency": self.currency?.rawValue,
            "flow": self.flow,
            "livemode": self.isLive,
            "status": self.status?.rawValue,
            "type": self.type?.rawValue,
            "usage": self.usage,
            "metadata": self.metadata,
            "owner": self.owner,
            "receiver": self.reciever
        ]
        return try Node(node: object)
    }
}
