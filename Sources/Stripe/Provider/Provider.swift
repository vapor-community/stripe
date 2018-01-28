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

    fileprivate init(config: StripeConfig, client: Client) {
        let balanceAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        balance = StripeBalanceRoutes(request: balanceAPIRequest)
        
        let chargeAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        charge = StripeChargeRoutes(request: chargeAPIRequest)
        
        let connectAccountAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        connectAccount = StripeConnectAccountRoutes(request: connectAccountAPIRequest)
        
        let couponAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        coupon = StripeCouponRoutes(request: couponAPIRequest)
        
        let customerAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        customer = StripeCustomerRoutes(request: customerAPIRequest)
        
        let disputeAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        dispute = StripeDisputeRoutes(request: disputeAPIRequest)
        
        let ephemeralKeyAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        ephemeralKey = StripeEphemeralKeyRoutes(request: ephemeralKeyAPIRequest)
        
        let invoiceItemAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        invoiceItem = StripeInvoiceItemRoutes(request: invoiceItemAPIRequest)
        
        let invoiceAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        invoice = StripeInvoiceRoutes(request: invoiceAPIRequest)
        
        let orderReturnAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        orderReturn = StripeOrderReturnRoutes(request: orderReturnAPIRequest)
        
        let orderAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        order = StripeOrderRoutes(request: orderAPIRequest)
        
        let planAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        plan = StripePlanRoutes(request: planAPIRequest)
        
        let productAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        product = StripeProductRoutes(request: productAPIRequest)
        
        let refundAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        refund = StripeRefundRoutes(request: refundAPIRequest)
        
        let skuAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        sku = StripeSKURoutes(request: skuAPIRequest)
        
        let sourceAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        source = StripeSourceRoutes(request: sourceAPIRequest)

        let subscriptionItemAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        subscriptionItem = StripeSubscriptionItemRoutes(request: subscriptionItemAPIRequest)
        
        let subscriptionAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        subscription = StripeSubscriptionRoutes(request: subscriptionAPIRequest)
        
        let tokenAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        token = StripeTokenRoutes(request: tokenAPIRequest)
    }
}
