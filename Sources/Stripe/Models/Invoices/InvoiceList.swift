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

public struct InvoicesList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var totalCount: Int
    public var url: String
    public var data: [StripeInvoice]
    
    public enum CodingKeys: CodingKey, String {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case data
    }
}
