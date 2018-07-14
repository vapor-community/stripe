//
//  DisputeRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/12/17.
//
//

import Vapor

public protocol DisputeRoutes {
    func retrieve(dispute: String) throws -> Future<StripeDispute>
    func update(dispute: String, disputeEvidence: StripeDisputeEvidence?, metadata: [String: String]?, submit: Bool?) throws -> Future<StripeDispute>
    func close(dispute: String) throws -> Future<StripeDispute>
    func listAll(filter: [String: Any]?) throws -> Future<DisputesList>
}

extension DisputeRoutes {
    public func retrieve(dispute: String) throws -> Future<StripeDispute> {
        return try retrieve(dispute: dispute)
    }
    
    public func update(dispute: String, disputeEvidence: StripeDisputeEvidence? = nil, metadata: [String : String]? = nil, submit: Bool? = nil) throws -> Future<StripeDispute> {
        return try update(dispute: dispute, disputeEvidence: disputeEvidence, metadata: metadata, submit: submit)
    }
    
    public func close(dispute: String) throws -> Future<StripeDispute> {
        return try close(dispute: dispute)
    }
    
    public func listAll(filter: [String : Any]? = nil) throws -> Future<DisputesList> {
        return try listAll(filter: filter)
    }
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
