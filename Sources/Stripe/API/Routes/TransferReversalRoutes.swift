//
//  TransferReversalRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/3/18.
//

import Vapor

public protocol TransferReversalRoutes {
    func create(id: String, amount: Int?, description: String?, metadata: [String: String]?, refundApplicationFee: Bool?) throws -> Future<StripeTransferReversal>
    func retrieve(transfer: String, reversal: String) throws -> Future<StripeTransferReversal>
    func update(transfer: String, reversal: String, metadata: [String: String]?) throws -> Future<StripeTransferReversal>
    func listAll(reversal: String, filter: [String: Any]?) throws -> Future<TransferReversalList>
}

extension TransferReversalRoutes {
    public func create(id: String,
                       amount: Int? = nil,
                       description: String? = nil,
                       metadata: [String: String]? = nil,
                       refundApplicationFee: Bool? = nil) throws -> Future<StripeTransferReversal> {
        return try create(id: id,
                          amount: amount,
                          description: description,
                          metadata: metadata,
                          refundApplicationFee: refundApplicationFee)
    }
    
    public func retrieve(transfer: String, reversal: String) throws -> Future<StripeTransferReversal> {
        return try retrieve(transfer: transfer, reversal: reversal)
    }
    
    public func update(transfer: String,
                       reversal: String,
                       metadata: [String: String]? = nil) throws -> Future<StripeTransferReversal> {
        return try update(transfer: transfer,
                           reversal: reversal,
                           metadata: metadata)
    }
    
    public func listAll(reversal: String, filter: [String: Any]? = nil) throws -> Future<TransferReversalList> {
        return try listAll(reversal: reversal, filter: filter)
    }
    
}

public struct StripeTransferReversalRoutes: TransferReversalRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    /// Create a transfer reversal
    /// [Learn More →](https://stripe.com/docs/api/curl#create_transfer_reversal)
    public func create(id: String,
                       amount: Int?,
                       description: String?,
                       metadata: [String: String]?,
                       refundApplicationFee: Bool?) throws -> Future<StripeTransferReversal> {
        var body: [String: Any] = [:]
        
        if let amount = amount {
            body["amount"] = amount
        }
        
        if let description = description {
            body["description"] = description
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let refundApplicationFee = refundApplicationFee {
            body["refund_application_fee"] = refundApplicationFee
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.transferReversal(id).endpoint, body: body.queryParameters)
    }
    
    /// Retrieve a reversal
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_transfer_reversal)
    public func retrieve(transfer: String, reversal: String) throws -> Future<StripeTransferReversal> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.transfersReversal(transfer, reversal).endpoint)
    }
    
    /// Update a reversal
    /// [Learn More →](https://stripe.com/docs/api/curl#update_transfer_reversal)
    public func update(transfer: String,
                       reversal: String,
                       metadata: [String: String]?) throws -> Future<StripeTransferReversal> {
        var body: [String: Any] = [:]
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.transfersReversal(transfer, reversal).endpoint, body: body.queryParameters)
    }
    
    /// List all reversals
    /// [Learn More →](https://stripe.com/docs/api/curl#list_transfer_reversals)
    public func listAll(reversal: String, filter: [String: Any]?) throws -> Future<TransferReversalList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return try request.send(method: .GET, path: StripeAPIEndpoint.transferReversal(reversal).endpoint, query: queryParams)
    }
}

