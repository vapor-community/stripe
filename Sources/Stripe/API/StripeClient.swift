//
//  Stripe.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Vapor

public class StripeClient {

    public let apiKey: String

    public private(set) var balance: BalanceRoutes!
    public private(set) var charge: ChargeRoutes!
    public private(set) var customer: CustomerRoutes!
    public private(set) var tokens: TokenRoutes!
    public private(set) var refunds: RefundRoutes!
    public private(set) var coupons: CouponRoutes!
    public private(set) var plans: PlanRoutes!
    public private(set) var sources: SourceRoutes!
    public private(set) var subscriptionItems: SubscriptionItemRoutes!
    public private(set) var subscriptions: SubscriptionRoutes!
    public private(set) var account: AccountRoutes!
    public private(set) var disputes: DisputeRoutes!
    public private(set) var skus: SKURoutes!
    public private(set) var products: ProductRoutes!
    public private(set) var orders: OrderRoutes!
    public private(set) var orderReturns: OrderReturnRoutes!
    public private(set) var invoices: InvoiceRoutes!
    public private(set) var invoiceItems: InvoiceItemRoutes!

    public init(apiKey: String) throws {
        self.apiKey = apiKey
    }

    public func initializeRoutes() {
        self.balance = BalanceRoutes(client: self)
        self.charge = ChargeRoutes(client: self)
        self.customer = CustomerRoutes(client: self)
        self.tokens = TokenRoutes(client: self)
        self.refunds = RefundRoutes(client: self)
        self.coupons = CouponRoutes(client: self)
        self.plans = PlanRoutes(client: self)
        self.sources = SourceRoutes(client: self)
        self.subscriptionItems = SubscriptionItemRoutes(client: self)
        self.subscriptions = SubscriptionRoutes(client: self)
        self.account = AccountRoutes(client: self)
        self.disputes = DisputeRoutes(client: self)
        self.skus = SKURoutes(client: self)
        self.products = ProductRoutes(client: self)
        self.orders = OrderRoutes(client: self)
        self.orderReturns = OrderReturnRoutes(client: self)
        self.invoices = InvoiceRoutes(client: self)
        self.invoiceItems = InvoiceItemRoutes(client: self)
    }
}
