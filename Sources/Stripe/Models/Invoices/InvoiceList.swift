//
//  InvoiceList.swift
//  Stripe
//
//  Created by Andrew Edwards on 12/7/17.
//

/**
 Invoices list
 https://stripe.com/docs/api#list_invoices
 */

public struct InvoicesList: List, StripeModel {
    public var object: String?
    public var hasMore: Bool?
    public var totalCount: Int?
    public var url: String?
    public var items: [StripeInvoice]?
    
    enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case items = "data"
    }
}
