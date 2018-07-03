//
//  TransferReversalList.swift
//  Stripe
//
//  Created by Andrew Edwards on 4/3/18.
//

/**
 Connected Account list
 https://stripe.com/docs/api/curl#transfer_object-reversals
 */

public struct TransferReversalList: StripeModel {
    public var object: String
    public var hasMore: Bool
    public var totalCount: Int
    public var url: String
    public var data: [StripeTransferReversal]
    
    public enum CodingKeys: String, CodingKey {
        case object
        case hasMore = "has_more"
        case totalCount = "total_count"
        case url
        case data
    }
}
