//
//  TransferList.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/3/18.
//

import Foundation

/**
 Transfers list
 https://stripe.com/docs/api/curl#list_transfers
 */

public struct TransferList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var totalCount: Int
    public var url: String
    public var data: [StripeTransfer]
    
    public enum CodingKeys: CodingKey, String {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case data
    }
}
