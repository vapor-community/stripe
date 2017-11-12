//
//  EphemeralKeyRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 10/17/17.
//

import HTTP
import Node

open class EphemeralKeyRoutes {
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    public func create(customerId: String) throws -> StripeRequest<EphemeralKey> {
        
        let node = try Node(node: ["customer": customerId])
        
        return try StripeRequest(client: self.client, method: .post, route: .ephemeralKeys, query: [:], body: Body.data(node.formURLEncoded()), headers: nil)
    }
    
    public func delete(ephemeralKeyId: String) throws -> StripeRequest<EphemeralKey> {
        
        return try StripeRequest(client: self.client, method: .delete, route: .ephemeralKey(ephemeralKeyId), query: [:], body: nil, headers: nil)
    }
}
