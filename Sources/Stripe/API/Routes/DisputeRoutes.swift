//
//  DisputeRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/12/17.
//
//

import Vapor

public protocol DisputeRoutes {
    associatedtype D: Dispute
    associatedtype DE: DisputeEvidence
    associatedtype L: List
    
    func retrieve(dispute: String) throws -> Future<D>
    func update(dispute: String, disputeEvidence: DE?, metadata: [String: String]?, submit: Bool?) throws -> Future<D>
    func close(dispute: String) throws -> Future<D>
    func listAll(filter: [String: Any]?) throws -> Future<L>
}

public struct StripeDisputeRoutes: DisputeRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    /// Retrieve a dispute
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_dispute)
    public func retrieve(dispute: String) throws -> Future<StripeDispute> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.disputes(dispute).endpoint)
    }
    
    /// Update a dispute
    /// [Learn More →](https://stripe.com/docs/api/curl#update_dispute)
    public func update(dispute: String, disputeEvidence: StripeDisputeEvidence?, metadata: [String : String]?, submit: Bool?) throws -> Future<StripeDispute> {
        var body: [String: Any] = [:]
        
        if let disputeEvidence = disputeEvidence {
           try disputeEvidence.toEncodedDictionary().forEach { body["evidence[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let submit = submit {
            body["submit"] = submit
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.disputes(dispute).endpoint, body: body.queryParameters)
    }
    
    /// Close a dispute
    /// [Learn More →](https://stripe.com/docs/api/curl#close_dispute)
    public func close(dispute: String) throws -> Future<StripeDispute> {
        return try request.send(method: .POST, path: StripeAPIEndpoint.closeDispute(dispute).endpoint)
    }
    
    /// List all disputes
    /// [Learn More →](https://stripe.com/docs/api/curl#list_disputes)
    public func listAll(filter: [String : Any]?) throws -> Future<DisputesList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        
        return try request.send(method: .GET, path: StripeAPIEndpoint.dispute.endpoint, query: queryParams)
    }
}
