//
//  EphemeralKeyRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 10/17/17.
//


import Vapor

public protocol EphemeralKeyRoutes {
    associatedtype EK: EphemeralKey
    
    func create(customer: String) throws -> Future<EK>
    func delete(ephemeralKey: String) throws -> Future<EK>
}

public struct StripeEphemeralKeyRoutes: EphemeralKeyRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }
    
    public func create(customer: String) throws -> Future<StripeEphemeralKey> {
        let body = ["customer": customer]
        return try request.send(method: .POST, path: StripeAPIEndpoint.ephemeralKeys.endpoint, body: body.queryParameters)
    }
    
    public func delete(ephemeralKey: String) throws -> Future<StripeEphemeralKey> {
        return try request.send(method: .DELETE, path: StripeAPIEndpoint.ephemeralKey(ephemeralKey).endpoint)
    }
}
