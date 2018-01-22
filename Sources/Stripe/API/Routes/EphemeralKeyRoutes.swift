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

public struct StripeEphemeralKeyRoutes<SR: StripeRequest>: EphemeralKeyRoutes {
    private let request: SR
    
    init(request: SR) {
        self.request = request
    }
    
    public func create(customer: String) throws -> Future<StripeEphemeralKey> {
        let body = ["customer": customer]
        return try request.send(method: .post, path: StripeAPIEndpoint.ephemeralKeys.endpoint, body: body.queryParameters)
    }
    
    public func delete(ephemeralKey: String) throws -> Future<StripeEphemeralKey> {
        return try request.send(method: .delete, path: StripeAPIEndpoint.ephemeralKey(ephemeralKey).endpoint)
    }
}