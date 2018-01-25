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
    public let dispute: StripeDisputeRoutes<StripeAPIRequest>
    public let ephemeralKey: StripeEphemeralKeyRoutes<StripeAPIRequest>
    public let invoiceItem: StripeInvoiceItemRoutes<StripeAPIRequest>
    public let invoice: StripeInvoiceRoutes<StripeAPIRequest>
    public let orderReturn: StripeOrderReturnRoutes<StripeAPIRequest>
    public let order: StripeOrderRoutes<StripeAPIRequest>
    public let plan: StripePlanRoutes<StripeAPIRequest>
    public let product: StripeProductRoutes<StripeAPIRequest>
    public let refund: StripeRefundRoutes<StripeAPIRequest>
    public let sku: StripeSKURoutes<StripeAPIRequest>

    fileprivate init(config: StripeConfig, client: Client) {
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
        
        let disputeAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        dispute = StripeDisputeRoutes<StripeAPIRequest>(request: disputeAPIRequest)
        
        let ephemeralKeyAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        ephemeralKey = StripeEphemeralKeyRoutes<StripeAPIRequest>(request: ephemeralKeyAPIRequest)
        
        let invoiceItemAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        invoiceItem = StripeInvoiceItemRoutes<StripeAPIRequest>(request: invoiceItemAPIRequest)
        
        let invoiceAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        invoice = StripeInvoiceRoutes<StripeAPIRequest>(request: invoiceAPIRequest)
        
        let orderReturnAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        orderReturn = StripeOrderReturnRoutes<StripeAPIRequest>(request: orderReturnAPIRequest)
        
        let orderAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        order = StripeOrderRoutes<StripeAPIRequest>(request: orderAPIRequest)
        
        let planAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        plan = StripePlanRoutes<StripeAPIRequest>(request: planAPIRequest)
        
        let productAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        product = StripeProductRoutes<StripeAPIRequest>(request: productAPIRequest)
        
        let refundAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        refund = StripeRefundRoutes<StripeAPIRequest>(request: refundAPIRequest)
        
        let skuAPIRequest = StripeAPIRequest(httpClient: client, apiKey: config.apiKey)
        sku = StripeSKURoutes<StripeAPIRequest>(request: skuAPIRequest)
    }
}
