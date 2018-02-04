//
//  List.swift
//  Stripe
//
//  Created by Andrew Edwards on 12/3/17.
//

public protocol List {
    associatedtype T: StripeModel
    var object: String? { get }
    var hasMore: Bool? { get }
    var totalCount: Int? { get }
    var url: String? { get }
    var data: [T]? { get }
}
