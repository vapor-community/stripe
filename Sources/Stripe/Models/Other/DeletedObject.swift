//
//  DeletedObject.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//

import Vapor

/**
 Deleted object
 https://stripe.com/docs/api/curl#delete_customer
 */

public protocol DeletedObject {
    var deleted: Bool? { get }
    var id: String? { get }
}

public struct StripeDeletedObject: DeletedObject, StripeModel {
    public var deleted: Bool?
    public var id: String?
}
