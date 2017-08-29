//
//  DisputeRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/12/17.
//
//

import Foundation
import Node
import HTTP

public final class DisputeRoutes {
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    public func retrieve( dispute disputeId: String) throws -> StripeRequest<Dispute> {
        return try StripeRequest(client: self.client, method: .get, route: .disputes(disputeId), query: [:], body: nil, headers: nil)
    }
    
    public func update(dispute disputeId: String, evidence: Node?, submit: Bool?, metadata: Node? = nil) throws -> StripeRequest<Dispute> {
        var body = Node([:])
        
        if let evidence = evidence?.object {
            for (key, value) in evidence {
                body["evidence[\(key)]"] = value
            }
        }
        
        if let submit = submit {
            body["submit"] = Node(submit)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .disputes(disputeId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    public func close(dispute disputeId: String) throws -> StripeRequest<Dispute> {
        return try StripeRequest(client: self.client, method: .post, route: .closeDispute(disputeId), query: [:], body: nil, headers: nil)
    }
    
    public func listAll(filter: StripeFilter?) throws -> StripeRequest<DisputeList> {
        var query = [String : NodeRepresentable]()
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .dispute, query: query, body: nil, headers: nil)
    }
}
