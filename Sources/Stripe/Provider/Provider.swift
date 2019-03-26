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

public final class StripeClient: Service {
    public var balance: BalanceRoutes
    public var charge: ChargeRoutes
    public var connectAccount: AccountRoutes
    public var coupon: CouponRoutes
    public var customer: CustomerRoutes
    public var dispute: DisputeRoutes
    public var ephemeralKey: EphemeralKeyRoutes
    public var invoiceItem: InvoiceItemRoutes
    public var invoice: InvoiceRoutes
    public var orderReturn: OrderReturnRoutes
    public var order: OrderRoutes
    public var plan: PlanRoutes
    public var product: ProductRoutes
    public var refund: RefundRoutes
    public var sku: SKURoutes
    public var source: SourceRoutes
    public var subscriptionItem: SubscriptionItemRoutes
    public var subscription: SubscriptionRoutes
    public var token: TokenRoutes
    public var transfer: TransferRoutes
    public var transferReversals: TransferReversalRoutes
    public var payouts: PayoutRoutes
    public var fileLinks: FileLinkRoutes
    public var files: FileRoutes
    public var person: PersonRoutes
    public var applicationFee: ApplicationFeesRoutes
    public var applicationFeeRefunds: ApplicationFeeRefundRoutes
    public var externalAccounts: ExternalAccountsRoutes
    public var countrySpecs: CountrySpecRoutes
    public var topup: TopUpRoutes

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
        payouts = StripePayoutRoutes(request: apiRequest)
        fileLinks = StripeFileLinkRoutes(request: apiRequest)
        files = StripeFileRoutes(request: apiRequest)
        person = StripePersonRoutes(request: apiRequest)
        applicationFee = StripeApplicationFeeRoutes(request: apiRequest)
        applicationFeeRefunds = StripeApplicationFeeRefundRoutes(request: apiRequest)
        externalAccounts = StripeExternalAccountsRoutes(request: apiRequest)
        countrySpecs = StripeCountrySpecRoutes(request: apiRequest)
        topup = StripeTopUpRoutes(request: apiRequest)
    }
}
