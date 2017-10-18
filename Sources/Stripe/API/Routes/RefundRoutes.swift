//
//  RefundRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/13/17.
//
//

import Node
import HTTP

public final class RefundRoutes {
    
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Create a refund
     When you create a new refund, you must specify a charge to create it on.
     Creating a new refund will refund a charge that has previously been created but not yet refunded. 
     Funds will be refunded to the credit or debit card that was originally charged. The fees you were 
     originally charged are also refunded.
     You can optionally refund only part of a charge. You can do so as many times as you wish until the 
     entire charge has been refunded. Once entirely refunded, a charge can't be refunded again. This 
     method will return an error when called on an already-refunded charge, or when trying to refund more 
     money than is left on a charge.
     
     - parameter charge:               The identifier of the charge to refund.
     
     - parameter amount:               A positive integer in cents representing how much of this charge to refund. 
                                       Can only refund up to the unrefunded amount remaining of the charge.
     
     - parameter reason:               String indicating the reason for the refund. If set, possible values
                                       are duplicate, fraudulent, and requestedByCustomer. Specifying fraudulent 
                                       as the reason when you believe the charge to be fraudulent will help us 
                                       improve our fraud detection algorithms.
     
     - parameter refundApplicationFee: Boolean indicating whether the application fee should be refunded when 
                                       refunding this charge. If a full charge refund is given, the full 
                                       application fee will be refunded. Else, the application fee will be 
                                       refunded with an amount proportional to the amount of the charge refunded.
                                       An application fee can only be refunded by the application that created 
                                       the charge.
     
     - parameter reverseTransfer:      Boolean indicating whether the transfer should be reversed when refunding this 
                                       charge. The transfer will be reversed for the same amount being refunded 
                                       (either the entire or partial amount).
                                       A transfer can only be reversed by the application that created the charge.
     
     - parameter metadata:             A set of key/value pairs that you can attach to a refund object. It can be
                                        useful for storing additional information about the refund in a structured format.
                                        You can unset individual keys if you POST an empty value for that key. You can clear
                                        all keys if you POST an empty value for metadata.

     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    public func createRefund(charge: String, amount: Int? = nil, reason: RefundReason? = nil, refundApplicationFee: Bool? = nil, reverseTransfer: Bool? = nil, metadata: Node? = nil, inConnectAccount account: String? = nil) throws -> StripeRequest<RefundItem> {
        var body = Node([:])
        
        body["charge"] = Node(charge)
        
        if let amount = amount {
            body["amount"] = Node(amount)
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        if let reason = reason {
            body["reason"] = Node(reason.rawValue)
        }
        
        if let refundApplicationFee = refundApplicationFee {
            body["refund_application_fee"] = Node(refundApplicationFee)
        }
        
        if let reverseTransfer = reverseTransfer {
            body["reverse_transfer"] = Node(reverseTransfer)
        }
        
        var headers: [HeaderKey: String]?
        
        // Check if we have an account to set it to
        if let account = account {
            headers = [StripeHeader.Account : account]
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .refunds, body: Body.data(body.formURLEncoded()), headers: headers)
    }
    
    /**
     Retrieve a refund
     Retrieves the details of an existing refund.
     
     - parameter refundId: The ID of refund to retrieve.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    public func retrieve(refund refundId: String) throws -> StripeRequest<RefundItem> {
        return try StripeRequest(client: self.client, method: .get, route: .refund(refundId))
    }
    
    /**
     Update a refund
     Updates the specified refund by setting the values of the parameters passed. Any parameters not provided will 
     be left unchanged.
     
     - parameter metadata: A set of key/value pairs that you can attach to a refund object. It can be useful for 
                           storing additional information about the refund in a structured format. You can unset 
                           individual keys if you POST an empty value for that key. You can clear all keys if you 
                           POST an empty value for metadata.
     
     - parameter refund:   The ID of the refund to update.
     
      - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
    */
    public func update(metadata: Node? = nil, refund refundId: String) throws -> StripeRequest<RefundItem> {
        var body = Node([:])
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        return try StripeRequest(client: self.client, method: .post, route: .refund(refundId), body: Body.data(body.formURLEncoded()))
    }
    
    /**
     Returns a list of all refunds you’ve previously created. The refunds are returned in sorted order, with the most 
     recent refunds appearing first. For convenience, the 10 most recent refunds are always available by default on 
     the charge object.
     
     - parameter byChargeId:    Only return refunds for the charge specified by this charge ID.
     
     - parameter filter:        A Filter item to pass query parameters when fetching results
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    public func listAll(byChargeId charge: String? = nil, filter: StripeFilter? = nil) throws -> StripeRequest<Refund> {
        var query = [String : NodeRepresentable]()
        
        if let data = try filter?.createQuery() {
            query = data
        }
        
        if let charge = charge {
            query["charge"] = Node(charge)
        }
        
        return try StripeRequest(client: self.client, method: .get, route: .refunds, query: query)
    }
}
