//
//  CouponRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/28/17.
//
//

import Foundation
import Vapor

public protocol CouponRoutes {
    func create(id: String?, duration: StripeDuration, amountOff: Int?, currency: StripeCurrency?, durationInMonths: Int?, maxRedemptions: Int?, metadata: [String: String]?, percentOff: Int?, redeemBy: Date?) throws -> Future<StripeCoupon>
    func retrieve(coupon: String) throws -> Future<StripeCoupon>
    func update(coupon: String, metadata: [String: String]?) throws -> Future<StripeCoupon>
    func delete(coupon: String) throws -> Future<StripeDeletedObject>
    func listAll(filter: [String: Any]?) throws -> Future<CouponsList>
}

public struct StripeCouponRoutes: CouponRoutes {
    private let request: StripeRequest
    
    init(request: StripeRequest) {
        self.request = request
    }

    /// Create a coupon
    /// [Learn More →](https://stripe.com/docs/api/curl#create_coupon)
    public func create(id: String? = nil,
                       duration: StripeDuration,
                       amountOff: Int? = nil,
                       currency: StripeCurrency? = nil,
                       durationInMonths: Int? = nil,
                       maxRedemptions: Int? = nil,
                       metadata: [String : String]? = nil,
                       percentOff: Int? = nil,
                       redeemBy: Date? = nil) throws -> Future<StripeCoupon> {
        var body: [String: Any] = [:]
        
        body["duration"] = duration.rawValue

        if let amountOff = amountOff {
            body["amount_off"] = amountOff
        }

        if let currency = currency {
            body["currency"] = currency.rawValue
        }

        if let durationInMonths = durationInMonths {
            body["duration_in_months"] = durationInMonths
        }

        if let maxRedemptions = maxRedemptions {
            body["max_redemptions"] = maxRedemptions
        }

        if let percentOff = percentOff {
            body["percent_off"] = percentOff
        }

        if let redeemBy = redeemBy {
            body["redeem_by"] = Int(redeemBy.timeIntervalSince1970)
        }

        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.coupons.endpoint, body: body.queryParameters)
    }
    
    /// Retrieve coupon
    /// [Learn More →](https://stripe.com/docs/api/curl#retrieve_coupon)
    public func retrieve(coupon: String) throws -> Future<StripeCoupon> {
        return try request.send(method: .GET, path: StripeAPIEndpoint.coupon(coupon).endpoint)
    }
    
    /// Update coupon
    /// [Learn More →](https://stripe.com/docs/api/curl#update_coupon)
    public func update(coupon: String, metadata: [String : String]? = nil) throws -> Future<StripeCoupon> {
        var body: [String: Any] = [:]
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        return try request.send(method: .POST, path: StripeAPIEndpoint.coupon(coupon).endpoint, body: body.queryParameters)
    }
    
    /// Delete coupon
    /// [Learn More →](https://stripe.com/docs/api/curl#delete_coupon)
    public func delete(coupon: String) throws -> Future<StripeDeletedObject> {
        return try request.send(method: .DELETE, path: StripeAPIEndpoint.coupon(coupon).endpoint)
    }
    
    /// List all coupons
    /// [Learn More →](https://stripe.com/docs/api/curl#list_coupons)
    public func listAll(filter: [String: Any]? = nil) throws -> Future<CouponsList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }

        return try request.send(method: .GET, path: StripeAPIEndpoint.coupons.endpoint, query: queryParams)
    }
}
