//
//  Stripe.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Vapor

public struct StripeConfig: Service {
    let apiKey: String
    public init(apiKey: String) {
        self.apiKey = apiKey
    }
}

public final class StripeProvider: Provider {
    public static let repositoryName = "stripe-provider"
    
    public init(){}
    public func boot(_ worker: Container) throws {}
    
    public func didBoot(_ worker: Container) throws -> EventLoopFuture<Void> {
        return .done(on: worker)
    }
    
    public func register(_ services: inout Services) throws {
        services.register { (container) -> StripeClient in
            let httpClient = try container.make(Client.self)
            let config = try container.make(StripeConfig.self)
            return StripeClient(config: config, client: httpClient)
        }
    }
}

public struct StripeClient: Service {
    public let balance: StripeBalanceRoutes
    public let charge: StripeChargeRoutes
    public let connectAccount: StripeConnectAccountRoutes
    public let coupon: StripeCouponRoutes
    public let customer: StripeCustomerRoutes
    public let dispute: StripeDisputeRoutes
    public let ephemeralKey: StripeEphemeralKeyRoutes
    public let invoiceItem: StripeInvoiceItemRoutes
    public let invoice: StripeInvoiceRoutes
    public let orderReturn: StripeOrderReturnRoutes
    public let order: StripeOrderRoutes
    public let plan: StripePlanRoutes
    public let product: StripeProductRoutes
    public let refund: StripeRefundRoutes
    public let sku: StripeSKURoutes
    public let source: StripeSourceRoutes
    public let subscriptionItem: StripeSubscriptionItemRoutes
    public let subscription: StripeSubscriptionRoutes
    public let token: StripeTokenRoutes

    internal init(config: StripeConfig, client: Client) {
        let apiRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        
        balance = StripeBalanceRoutes(request: apiRequest)
        charge = StripeChargeRoutes(request: apiRequest)
        connectAccount = StripeConnectAccountRoutes(request: apiRequest)
        coupon = StripeCouponRoutes(request: apiRequest)
        customer = StripeCustomerRoutes(request: apiRequest)
        dispute = StripeDisputeRoutes(request: apiRequest)
        ephemeralKey = StripeEphemeralKeyRoutes(request: apiRequest)
        invoiceItem = StripeInvoiceItemRoutes(request: apiRequest)
        invoice = StripeInvoiceRoutes(request: apiRequest)
        orderReturn = StripeOrderReturnRoutes(request: apiRequest)
        order = StripeOrderRoutes(request: apiRequest)
        plan = StripePlanRoutes(request: apiRequest)
        product = StripeProductRoutes(request: apiRequest)
        refund = StripeRefundRoutes(request: apiRequest)
        sku = StripeSKURoutes(request: apiRequest)
        source = StripeSourceRoutes(request: apiRequest)
        subscriptionItem = StripeSubscriptionItemRoutes(request: apiRequest)
        subscription = StripeSubscriptionRoutes(request: apiRequest)
        token = StripeTokenRoutes(request: apiRequest)
    }
}
