//
//  SourceRedirect.swift
//  Stripe
//
//  Created by Andrew Edwards on 12/4/17.
//

public struct SourceRedirect: StripeModel {
    public var failureReason: String?
    public var returnUrl: String?
    public var status: String?
    public var url: String?
    
    public enum CodingKeys: String, CodingKey {
        case failureReason = "failure_reason"
        case returnUrl = "return_url"
        case status
        case url
    }
}
