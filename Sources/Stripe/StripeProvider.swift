//
//  StripeProvider.swift
//  
//
//  Created by Andrew Edwards on 6/14/19.
//

import Vapor
@_exported import StripeKit

public struct StripeConfiguration {
    public var apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
}

public final class StripeProvider: Provider {
    public init() { }
    public func register(_ s: inout Services) {
        s.register(StripeClient.self) { container -> StripeClient in
            let providerConfiguration = try container.make(StripeConfiguration.self)
            return StripeClient(eventLoop: container.eventLoop, apiKey: providerConfiguration.apiKey)
        }
    }
}
