//
//  Endpoints.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import Foundation

internal let APIBase = "https://api.stripe.com/"
internal let FilesAPIBase = "https://files.stripe.com/"
internal let APIVersion = "v1/"

internal enum StripeAPIEndpoint {
    
    // MARK: - BALANCE
    case balance
    case balanceHistory
    case balanceHistoryTransaction(String)
    
    // MARK: - CHARGES
    case charges
    case charge(String)
    case captureCharge(String)
    
    // MARK: - CUSTOMERS
    case customers
    case customer(String)
    case customerSources(String)
    case customerDetachSources(String,String)
    case customerDiscount(String)
    
    // MARK: - TOKENS
    case tokens
    case token(String)
    
    // MARK: - REFUNDS
    case refunds
    case refund(String)
    
    // MARK: - COUPONS
    case coupons
    case coupon(String)
    
    // MARK: - PLANS
    case plans
    case plan(String)
    
    // MARK: - SOURCES
    case sources
    case source(String)
    
    // MARK: - SUBSCRIPTION ITEMS
    case subscriptionItem
    case subscriptionItems(String)
    
    // MARK: - SUBSCRIPTIONS
    case subscription
    case subscriptions(String)
    case subscriptionDiscount(String)
    
    // MARK: - ACCOUNTS
    case account
    case accounts(String)
    case accountsReject(String)
    case accountsLoginLink(String)
    
    // MARK: - DISPUTES
    case dispute
    case disputes(String)
    case closeDispute(String)
    
    // MARK: - SKUS
    case sku
    case skus(String)
    
    // MARK: - PRODUCTS
    case product
    case products(String)
    
    // MARK: - ORDERS
    case order
    case orders(String)
    case ordersPay(String)
    case ordersReturn(String)
    
    // MARK: - RETURNS
    case orderReturn
    case orderReturns(String)
    
    // MARK: - INVOICES
    case invoices
    case invoice(String)
    case payInvoice(String)
    case invoiceLines(String)
    case upcomingInvoices
    
    // MARK: - INVOICE ITEMS
    case invoiceItems
    case invoiceItem(String)
    
    // MARK: - EPHEMERAL KEYS
    case ephemeralKeys
    case ephemeralKey(String)
    
    // MARK: - TRANSFERS
    case transfer
    case transfers(String)
    case transferReversal(String)
    case transfersReversal(String,String)
    
    // MARK: - PAYOUTS
    case payout
    case payouts(String)
    case payoutsCancel(String)
    
    // MARK: - FILE LINKS
    case fileLink
    case fileLinks(String)
    
    // MARK: - FILE UPLOAD
    case file
    case files(String)
    
    // MARK: - PERSONS
    case person(String)
    case persons(String, String)
    
    case applicationFee
    case applicationFees(String)
    
    case applicationFeeRefund(String)
    case applicationFeeRefunds(String, String)
    
    case externalAccount(String)
    case externalAccounts(String, String)
    
    case countrySpec
    case countrySpecs(String)
    
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
        case .customerDetachSources(let id, let src): return APIBase + APIVersion + "customers/\(id)/sources/\(src)"
        case .customerDiscount(let id): return APIBase + APIVersion + "customers/\(id)/discount"
            
        case .tokens: return APIBase + APIVersion + "tokens"
        case .token(let id): return APIBase + APIVersion + "tokens/\(id)"
            
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
            
        case .transfer: return APIBase + APIVersion + "transfers"
        case .transfers(let id): return APIBase + APIVersion + "transfers/\(id)"
        case .transferReversal(let id): return APIBase + APIVersion + "transfers/\(id)/reversals"
        case .transfersReversal(let transfer, let reversal): return APIBase + APIVersion + "transfers/\(transfer)/reversals/\(reversal)"
        
        case .payout: return APIBase + APIVersion + "payouts"
        case .payouts(let id): return APIBase + APIVersion + "payouts/\(id)"
        case .payoutsCancel(let id): return APIBase + APIVersion + "payouts/\(id)/cancel"
            
        case .fileLink: return APIBase + APIVersion + "file_links"
        case .fileLinks(let id): return APIBase + APIVersion + "file_links/\(id)"
        
        case .file: return FilesAPIBase + APIVersion + "files"
        case .files(let id): return FilesAPIBase + APIVersion + "files/\(id)"
        
        case .person(let account): return APIBase + APIVersion + "accounts/\(account)/persons"
        case .persons(let account, let person): return APIBase + APIVersion + "accounts/\(account)/persons/\(person)"
            
        case .applicationFee: return APIBase + APIVersion + "application_fees"
        case .applicationFees(let fee): return APIBase + APIVersion + "application_fees/\(fee)"
            
        case .applicationFeeRefund(let fee): return APIBase + APIVersion + "application_fees/\(fee)/refunds"
        case .applicationFeeRefunds(let fee, let refund): return APIBase + APIVersion + "application_fees/\(fee)/refunds/\(refund)"
            
        case . externalAccount(let account): return APIBase + APIVersion + "accounts/\(account)/external_accounts"
        case . externalAccounts(let account, let id): return APIBase + APIVersion + "accounts/\(account)/external_accounts/\(id)"
            
        case .countrySpec: return APIBase + APIVersion + "country_specs"
        case .countrySpecs(let country): return APIBase + APIVersion + "country_specs/\(country)"
        }
    }
}
