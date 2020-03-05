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

public struct StripeDeletedObject: StripeModel {
    public var id: String
    public var object: String
    public var deleted: Bool
}
