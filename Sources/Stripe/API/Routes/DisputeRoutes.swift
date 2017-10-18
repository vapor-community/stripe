//
//  DisputeRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/12/17.
//
//

import Node
import HTTP

public final class DisputeRoutes {
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Retrieve a dispute
     Retrieves the dispute with the given ID.
     
     - parameter disputeId: ID of dispute to retrieve.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func retrieve(dispute disputeId: String) throws -> StripeRequest<Dispute> {
        return try StripeRequest(client: self.client, method: .get, route: .disputes(disputeId), query: [:], body: nil, headers: nil)
    }
    
    /**
     Update a dispute
     When you get a dispute, contacting your customer is always the best first step. If that doesn’t work, 
     you can submit evidence in order to help us resolve the dispute in your favor. You can do this in your 
     dashboard, but if you prefer, you can use the API to submit evidence programmatically.
     Depending on your dispute type, different evidence fields will give you a better chance of winning your dispute. 
     You may want to consult our guide to dispute types to help you figure out which evidence fields to provide.
     
     - parameter disputeId: ID of dispute to retrieve.
     - parameter evidence:  Evidence to upload to respond to a dispute. Updating any field in the hash will submit 
                            all fields in the hash for review.
     - parameter submit:    Whether or not to immediately submit evidence to the bank. If false, evidence is staged 
                            on the dispute. Staged evidence is visible in the API and Dashboard, and can be submitted 
                            to the bank by making another request with this attribute set to true (the default).
     - parameter metadata:  A set of key/value pairs that you can attach to a dispute object. It can be useful for storing 
                            additional information about the dispute in a structured format. You can unset individual keys 
                            if you POST an empty value for that key. You can clear all keys if you POST an empty value for metadata.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func update(dispute disputeId: String, evidence: Node? = nil, submit: Bool? = nil, metadata: Node? = nil) throws -> StripeRequest<Dispute> {
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
    
    /**
     Close a dispute
     Closing the dispute for a charge indicates that you do not have any evidence to submit and are essentially ‘dismissing’ 
     the dispute, acknowledging it as lost
     The status of the dispute will change from needs_response to lost. Closing a dispute is irreversible.
     
     - parameter disputeId: ID of dispute to close.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func close(dispute disputeId: String) throws -> StripeRequest<Dispute> {
        return try StripeRequest(client: self.client, method: .post, route: .closeDispute(disputeId), query: [:], body: nil, headers: nil)
    }
    
    /**
     List all disputes
     Returns a list of your disputes.
     
     - parameter filter: A Filter item to pass query parameters when fetching results
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func listAll(filter: StripeFilter? = nil) throws -> StripeRequest<DisputeList> {
        var query = [String : NodeRepresentable]()
        if let data = try filter?.createQuery() {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .dispute, query: query, body: nil, headers: nil)
    }
}
