//
//  Stripe.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Vapor

public struct StripeConfig {
    let apiKey: String
}

public final class StripeProvider: Provider {
    public static let repositoryName = "stripe-provider"
    
    public func boot(_ worker: Container) throws {}
    
    public func register(_ services: inout Services) throws {
        services.register { (container) -> StripeClient in
            let httpClient = try container.make(Client.self, for: StripeClient.self)
            let config = try container.make(StripeConfig.self, for: StripeClient.self)
            return StripeClient(config: config, client: httpClient)
        }
    }
}

public struct StripeClient: Service {
    public let balance: StripeBalanceRoutes<StripeAPIRequest>
    public let charge: StripeChargeRoutes<StripeAPIRequest>
    public let connectAccount: StripeConnectAccountRoutes<StripeAPIRequest>
    public let coupon: StripeCouponRoutes<StripeAPIRequest>
    public let customer: StripeCustomerRoutes<StripeAPIRequest>
    
    init(config: StripeConfig, client: Client) {
        let balanceAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        balance = StripeBalanceRoutes<StripeAPIRequest>(request: balanceAPIRequest)
        
        let chargeAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        charge = StripeChargeRoutes<StripeAPIRequest>(request: chargeAPIRequest)
        
        let connectAccountAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        connectAccount = StripeConnectAccountRoutes<StripeAPIRequest>(request: connectAccountAPIRequest)
        
        let couponAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        coupon = StripeCouponRoutes<StripeAPIRequest>(request: couponAPIRequest)
        
        let customerAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        customer = StripeCustomerRoutes<StripeAPIRequest>(request: customerAPIRequest)
    }
}
