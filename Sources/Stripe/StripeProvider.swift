//
//  StripeProvider.swift
//  
//
//  Created by Andrew Edwards on 6/14/19.
//

import Vapor
@_exported import StripeKit

public final class StripeProvider: Provider {
    private let apiKey: String
    
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    public func register(_ app: Application) {
        app.register(StripeClient.self) { app in
            return StripeClient(eventLoop: app.make(), apiKey: self.apiKey)
        }
    }
}
