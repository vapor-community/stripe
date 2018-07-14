//
//  TransferRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/3/18.
//

import Vapor

public protocol TransferRoutes {
    func create(amount: Int, currency: StripeCurrency, destination: String, metadata: [String: String]?, sourceTransaction: String?, transferGroup: String?) throws -> Future<StripeTransfer>
    func retrieve(transfer: String) throws -> Future<StripeTransfer>
    func update(transfer: String, metadata: [String: String]?) throws -> Future<StripeTransfer>
    func listAll(filter: [String: Any]?) throws -> Future<TransferList>
}

extension TransferRoutes {
    public func create(amount: Int,
                       currency: StripeCurrency,
                       destination: String,
                       metadata: [String: String]? = nil,
                       sourceTransaction: String? = nil,
                       transferGroup: String? = nil) throws -> EventLoopFuture<StripeTransfer> {
        return try create(amount: amount,
                           currency: currency,
                           destination: destination,
                           metadata: metadata,
                           sourceTransaction: sourceTransaction,
                           transferGroup: transferGroup)
    }
    
    public func retrieve(transfer: String) throws -> Future<StripeTransfer> {
        return try retrieve(transfer: transfer)
    }
    
    public func update(transfer: String, metadata: [String: String]? = nil) throws -> Future<StripeTransfer> {
        return try update(transfer: transfer, metadata: metadata)
    }
    
    public func listAll(filter: [String: Any]? = nil) throws -> Future<TransferList> {
        return try listAll(filter: filter)
    }
}

public struct StripeTransferRoutes: TransferRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    /// Create a transfer
    /// [Learn More →](https://stripe.com/docs/api/curl#create_transfer)
    public func create(amount: Int,
                       currency: StripeCurrency,
                       destination: String,
                       metadata: [String: String]?,
                       sourceTransaction: String?,
                       transferGroup: String?) throws -> Future<StripeTransfer> {
        var body: [String: Any] = [:]
        body["amount"] = amount
        body["currency"] = currency.rawValue
        body["destination"] = destination
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let sourceTransaction = sourceTransaction {
           body["source_transaction"] = sourceTransaction
        }
        
        if let transferGroup = transferGroup {
            body["transfer_group"] = transferGroup
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.transfer.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve a transfer
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_transfer)
    public func retrieve(transfer: String) throws -> Future<StripeTransfer> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.transfers(transfer).endpoint)
    }
    
    /// Update a transfer
    /// [Learn More →](https://stripe.com/docs/api/curl#update_transfer)
    public func update(transfer: String, metadata: [String: String]?) throws -> Future<StripeTransfer> {
        var body: [String: Any] = [:]
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.transfers(transfer).endpoint, body: body.queryParameters)
    }
    
    /// List all transfers
    /// [Learn More →](https://stripe.com/docs/api/curl#list_transfers)
    public func listAll(filter: [String: Any]?) throws -> Future<TransferList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return try request.send(method: .GET, path: StripeAPIEndpoint.transfer.endpoint, query: queryParams)
    }
}
