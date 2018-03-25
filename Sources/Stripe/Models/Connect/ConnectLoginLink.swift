//
//  ConnectLoginLink.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/9/17.
//
//

import Foundation

/**
 Login link object
 https://stripe.com/docs/api/curl#login_link_object
 */

public protocol ConnectLoginLink {
    var object: String? { get }
    var created: Date? { get }
    var url: String? { get }
}

public struct StripeConnectLoginLink: ConnectLoginLink, StripeModel {
    public var object: String?
    public var created: Date?
    public var url: String?
}
