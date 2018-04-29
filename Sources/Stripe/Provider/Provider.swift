//
//  Stripe.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Vapor

public struct StripeConfig: Service {
    public let apiKey: String
    public let testApiKey: String?

    public init(apiKey: String) {
        self.apiKey = apiKey
        self.testApiKey = nil
    }
    
    public init(productionKey: String, testKey: String) {
        self.apiKey = productionKey
        self.testApiKey = testKey
    }
}

public final class StripeProvider: Provider {
    public static let repositoryName = "stripe-provider"
    
    public init() { }
    
    public func boot(_ worker: Container) throws { }
    
    public func didBoot(_ worker: Container) throws -> EventLoopFuture<Void> {
        return .done(on: worker)
    }
    
    public func register(_ services: inout Services) throws {
        services.register { (container) -> StripeClient in
            let httpClient = try container.make(Client.self)
            let config = try container.make(StripeConfig.self)
            return StripeClient(apiKey: config.apiKey, testKey: config.testApiKey, client: httpClient)
        }
    }
}

public struct StripeClient: Service {
    public var balance: StripeBalanceRoutes
    public var charge: StripeChargeRoutes
    public var connectAccount: StripeConnectAccountRoutes
    public var coupon: StripeCouponRoutes
    public var customer: StripeCustomerRoutes
    public var dispute: StripeDisputeRoutes
    public var ephemeralKey: StripeEphemeralKeyRoutes
    public var invoiceItem: StripeInvoiceItemRoutes
    public var invoice: StripeInvoiceRoutes
    public var orderReturn: StripeOrderReturnRoutes
    public var order: StripeOrderRoutes
    public var plan: StripePlanRoutes
    public var product: StripeProductRoutes
    public var refund: StripeRefundRoutes
    public var sku: StripeSKURoutes
    public var source: StripeSourceRoutes
    public var subscriptionItem: StripeSubscriptionItemRoutes
    public var subscription: StripeSubscriptionRoutes
    public var token: StripeTokenRoutes
    public var transfer: StripeTransferRoutes
    public var transferReversals: StripeTransferReversalRoutes

    internal init(apiKey: String, testKey: String?, client: Client) {
        let apiRequest = StripeAPIRequest(httpClient: client, apiKey: apiKey, testApiKey: testKey)
        
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
        transfer = StripeTransferRoutes(request: apiRequest)
        transferReversals = StripeTransferReversalRoutes(request: apiRequest)
    }
}
