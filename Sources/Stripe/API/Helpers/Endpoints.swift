//
//  Endpoints.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Foundation
import HTTP

internal let APIBase = "https://api.stripe.com/"
internal let APIVersion = "v1/"

internal let DefaultHeaders = HTTPHeaders(dictionaryLiteral: ("Stripe-Version", "2017-08-15"), (HTTPHeaders.Name.contentType, "application/x-www-form-urlencoded"))

internal struct StripeHeader {
    static let Authorization = HTTPHeaders.Name.authorization
    static let Account = HTTPHeaders.Name("Stripe-Account")
}

internal enum API {
    
    /**
     BALANCE
     This is an object representing your Stripe balance. You can retrieve it to see the balance 
     currently on your Stripe account. You can also retrieve a list of the balance history, which 
     contains a list of transactions that contributed to the balance 
     (e.g., charges, transfers, and so forth). The available and pending amounts for each currency 
     are broken down further by payment source types.
     */
    case balance
    case balanceHistory
    case balanceHistoryTransaction(String)
    
    /**
     CHARGES
     To charge a credit or a debit card, you create a charge object. You can retrieve and refund 
     individual charges as well as list all charges. Charges are identified by a unique random ID.
    */
    case charges
    case charge(String)
    case captureCharge(String)
    
    /**
     CUSTOMERS
     Customers allow you to perform recurring charges and track multiple charges that are
     associated with the same customer. The API allows you to create, delete, and update your customers. 
     You can retrieve individual customers as well as a list of all your customers.
    */
    case customers
    case customer(String)
    case customerSources(String)
    case customerDiscount(String)
    
    /**
     TOKENS
     Tokenization is the process Stripe uses to collect sensitive card or bank account details, 
     or personally identifiable information (PII), directly from your customers in a secure manner. 
     A Token representing this information is returned to your server to use. You should use Checkout, 
     Elements, or Stripe mobile libraries to perform this process, client-side. This ensures that no 
     sensitive card data touches your server and allows your integration to operate in a PCI compliant way.
    */
    case tokens
    case token(String)
    
    /**
     REFUNDS
     Refund objects allow you to refund a charge that has previously been created but not yet refunded. 
     Funds will be refunded to the credit or debit card that was originally charged. The fees you were 
     originally charged are also refunded.
    */
    case refunds
    case refund(String)
    
    /**
     COUPONS
     A coupon contains information about a percent-off or amount-off discount you might want to 
     apply to a customer. Coupons may be applied to invoices or orders.
     */
    case coupons
    case coupon(String)
    
    /**
     PLANS
     A subscription plan contains the pricing information for different products and feature levels on your site.
     */
    case plans
    case plan(String)
    
    /**
     SOURCES
     Source objects allow you to accept a variety of payment methods. They represent a customer's payment instrument 
     and can be used with the Stripe API just like a card object: once chargeable, they can be charged, or attached 
     to customers.
     */
    case sources
    case source(String)
    
    /**
     SUBSCRIPTION ITEMS
     Subscription items allow you to create customer subscriptions with more than one plan, making it easy to represent 
     complex billing relationships.
     */
    case subscriptionItem
    case subscriptionItems(String)
    
    /**
     SUBSCRIPTIONS
     Subscriptions allow you to charge a customer's card on a recurring basis. A subscription ties a customer to a 
     particular plan you've created.
     */
    case subscription
    case subscriptions(String)
    case subscriptionDiscount(String)
    
    /**
     ACCOUNTS
     This is an object representing your Stripe account. You can retrieve it to see properties on the account like its 
     current e-mail address or if the account is enabled yet to make live charges.
     */
    case account
    case accounts(String)
    case accountsReject(String)
    case accountsLoginLink(String)
    
    /**
     DISPUTES
     A dispute occurs when a customer questions your charge with their bank or credit card company.
     */
    case dispute
    case disputes(String)
    case closeDispute(String)
    
    /**
     SKUS
     Stores representations of stock keeping units. SKUs describe specific product variations.
     */
    case sku
    case skus(String)
    
    /**
     PRODUCTS
     Store representations of products you sell in product objects, used in conjunction with SKUs.
     */
    case product
    case products(String)
    
    /**
     ORDERS
     The purchase of previously defined products
     */
    case order
    case orders(String)
    case ordersPay(String)
    case ordersReturn(String)
    
    /**
     RETURNS
     A return represents the full or partial return of a number of order items.
     */
    case orderReturn
    case orderReturns(String)
    
    /**
    INVOICES
    Invoices are statements of what a customer owes for a particular billing period, including subscriptions, 
    invoice items, and any automatic proration adjustments if necessary.
    */
    case invoices
    case invoice(String)
    case payInvoice(String)
    case invoiceLines(String)
    case upcomingInvoices
    
    /**
     INVOICE ITEMS
     Sometimes you want to add a charge or credit to a customer but only actually charge the customer's card at 
     the end of a regular billing cycle. This is useful for combining several charges to minimize per-transaction 
     fees or having Stripe tabulate your usage-based billing totals.
    */
    case invoiceItems
    case invoiceItem(String)
    
    
    /**
     EPHEMERAL KEYS
     */
    case ephemeralKeys
    case ephemeralKey(String)
    
    var endpoint: String {
        switch self {
        case .balance: return APIBase + APIVersion + "balance"
        case .balanceHistory: return APIBase + APIVersion + "balance/history"
        case .balanceHistoryTransaction(let id): return APIBase + APIVersion + "balance/history/\(id)"
        
        case .charges: return APIBase + APIVersion + "charges"
        case .charge(let id): return APIBase + APIVersion + "charges/\(id)"
        case .captureCharge(let id): return APIBase + APIVersion + "charges/\(id)/capture"
            
        case .customers: return APIBase + APIVersion + "customers"
        case .customer(let id): return APIBase + APIVersion + "customers/\(id)"
        case .customerSources(let id): return APIBase + APIVersion + "customers/\(id)/sources"
        case .customerDiscount(let id): return APIBase + APIVersion + "customers/\(id)/discount"
            
        case .tokens: return APIBase + APIVersion + "tokens"
        case .token(let token): return APIBase + APIVersion + "tokens/\(token)"
            
        case .refunds: return APIBase + APIVersion + "refunds"
        case .refund(let id): return APIBase + APIVersion + "refunds/\(id)"
            
        case .coupons: return APIBase + APIVersion + "coupons"
        case .coupon(let id): return APIBase + APIVersion + "coupons/\(id)"
            
        case .plans: return APIBase + APIVersion + "plans"
        case .plan(let id): return APIBase + APIVersion + "plans/\(id)"
            
        case .sources: return APIBase + APIVersion + "sources"
        case .source(let id): return APIBase + APIVersion + "sources/\(id)"
            
        case .subscriptionItem: return APIBase + APIVersion + "subscription_items"
        case .subscriptionItems(let id): return APIBase + APIVersion + "subscription_items/\(id)"
            
        case .subscription: return APIBase + APIVersion + "subscriptions"
        case .subscriptions(let id): return APIBase + APIVersion + "subscriptions/\(id)"
        case .subscriptionDiscount(let id): return APIBase + APIVersion + "subscriptions/\(id)/discount"
            
        case .account: return APIBase + APIVersion + "accounts"
        case .accounts(let id): return APIBase + APIVersion + "accounts/\(id)"
        case .accountsReject(let id): return APIBase + APIVersion + "accounts/\(id)/reject"
        case .accountsLoginLink(let id): return APIBase + APIVersion + "accounts/\(id)/login_links"
            
        case .dispute: return APIBase + APIVersion + "disputes"
        case .disputes(let id): return APIBase + APIVersion + "disputes/\(id)"
        case .closeDispute(let id): return APIBase + APIVersion + "disputes/\(id)/close"
            
        case .sku: return APIBase + APIVersion + "skus"
        case .skus(let id): return APIBase + APIVersion + "skus/\(id)"
            
        case .product: return APIBase + APIVersion + "products"
        case .products(let id): return APIBase + APIVersion + "products/\(id)"
            
        case .order: return APIBase + APIVersion + "orders"
        case .orders(let id): return APIBase + APIVersion + "orders/\(id)"
        case .ordersPay(let id): return APIBase + APIVersion + "orders/\(id)/pay"
        case .ordersReturn(let id): return APIBase + APIVersion + "orders/\(id)/returns"
            
        case .orderReturn: return APIBase + APIVersion + "order_returns"
        case .orderReturns(let id): return APIBase + APIVersion + "order_returns/\(id)"
            
        case .invoices: return APIBase + APIVersion + "invoices"
        case .invoice(let id): return APIBase + APIVersion + "invoices/\(id)"
        case .payInvoice(let id): return APIBase + APIVersion + "invoices/\(id)/pay"
        case .invoiceLines(let id): return APIBase + APIVersion + "invoices/\(id)/lines"
        case .upcomingInvoices: return APIBase + APIVersion + "invoices/upcoming"
            
        case .invoiceItems: return APIBase + APIVersion + "invoiceitems"
        case .invoiceItem(let id): return APIBase + APIVersion + "invoiceitems/\(id)"
        
        case .ephemeralKeys: return APIBase + APIVersion + "ephemeral_keys"
        case .ephemeralKey(let id): return APIBase + APIVersion + "ephemeral_keys/\(id)"
        }
    }
}
