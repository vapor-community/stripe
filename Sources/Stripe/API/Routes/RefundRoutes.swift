//
//  RefundRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/13/17.
//
//

import Vapor

public protocol RefundRoutes {
    associatedtype R: Refund
    associatedtype L: List
    
    func create(charge: String, amount: Int?, metadata: [String: String]?, reason: RefundReason?, refundApplicationFee: Bool?, reverseTransfer: Bool?) throws -> Future<R>
    func retrieve(refund: String) throws -> Future<R>
    func update(refund: String, metadata: [String: String]?) throws -> Future<R>
    func listAll(filter: [String: Any]?) throws -> Future<L>
}

public struct StripeRefundRoutes<SR: StripeRequest>: RefundRoutes {
    private let request: SR
    
    init(request: SR) {
        self.request = request
    }

    /// Create a refund
    /// [Learn More →](https://stripe.com/docs/api/curl#create_refund)
    public func create(charge: String,
                       amount: Int? = nil,
                       metadata: [String : String]? = nil,
                       reason: RefundReason? = nil,
                       refundApplicationFee: Bool? = nil,
                       reverseTransfer: Bool? = nil) throws -> Future<StripeRefund> {
        var body: [String: Any] = [:]
        
        body["charge"] = charge
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }

        if let refundReason = reason {
            body["reason"] = refundReason.rawValue
        }
        
        if let refundApplicationFee = refundApplicationFee {
            body["refund_application_fee"] = refundApplicationFee
        }
        
        if let reverseTransfer = reverseTransfer {
            body["reverse_transfer"] = reverseTransfer
        }
        
        return try request.send(method: .post, path: StripeAPIEndpoint.refunds.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve a refund
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_refund)
    public func retrieve(refund: String) throws -> Future<StripeRefund> {
        return try request.send(method: .get, path: StripeAPIEndpoint.refund(refund).endpoint)
    }
    
    /// Update a refund
    /// [Learn More →](https://stripe.com/docs/api/curl#update_refund)
    public func update(refund: String, metadata: [String : String]? = nil) throws -> Future<StripeRefund> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try request.send(method: .post, path: StripeAPIEndpoint.refund(refund).endpoint, body: body.queryParameters)
    }
    
    /// List all refunds
    /// [Learn More →](https://stripe.com/docs/api/curl#list_refunds)
    public func listAll(filter: [String : Any]? = nil) throws -> Future<RefundsList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .get, path: StripeAPIEndpoint.refunds.endpoint, query: queryParams)
    }
}
