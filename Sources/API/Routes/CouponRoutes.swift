//
//  CouponRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/28/17.
//
//

import Foundation
import Node
import HTTP
import Models
import Helpers
import Errors

public final class CouponRoutes {
    let client: StripeClient
    
    init(client: StripeClient) {
        self.client = client
    }
    
    /**
     Create a coupon
     Creates a new coupon object.
     
     - parameter id:                Unique string of your choice that will be used to identify this coupon when applying it to a customer.
                                    This is often a specific code you’ll give to your customer to use when signing up (e.g. FALL25OFF). If
                                    you don’t want to specify a particular code, you can leave the ID blank and Stripe will generate a
                                    random code for you.
     
     - parameter duration:          Specifies how long the discount will be in effect.
     
     - parameter amountOff:         Amount to subtract from an invoice total (required if percent_off is not passed).
     
     - parameter currency:          The currency in which the charge will be under. (required if amount_off passed).
     
     - parameter durationInMonths:  Required only if duration is `repeating`, in which case it must be a positive
                                    integer that specifies the number of months the discount will be in effect.
     
     - parameter maxRedemptions:    A positive integer specifying the number of times the coupon can be redeemed before it’s
                                    no longer valid.
     
     - parameter percentOff:        A positive integer between 1 and 100 that represents the discount the coupon will apply
                                    (required if amount_off is not passed).
     
     - parameter redeemBy:          Unix timestamp specifying the last time at which the coupon can be redeemed.
     
     - parameter metaData:          A set of key/value pairs that you can attach to a coupon object.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node.
     */
    
    public func create(id: String?, duration: StripeDuration, amountOff: Int?, currency: StripeCurrency?, durationInMonths: Int?, maxRedemptions: Int?, percentOff: Int?, redeemBy: Date?, metadata: Node?) throws -> StripeRequest<Coupon> {
        var body = Node([:])
        
        body["duration"] = Node(duration.rawValue)
        
        if let amountOff = amountOff {
            body["amount_off"] = Node(amountOff)
        }
        
        if let currency = currency {
            body["currency"] = Node(currency.rawValue)
        }
        
        if let durationInMonths = durationInMonths {
            body["duration_in_months"] = Node(durationInMonths)
        }
        
        if let maxRedemptions = maxRedemptions {
            body["max_redemptions"] = Node(maxRedemptions)
        }
        
        if let percentOff = percentOff {
            body["percent_off"] = Node(percentOff)
        }
        
        if let redeemBy = redeemBy {
            body["redeem_by"] = Node(Int(redeemBy.timeIntervalSince1970))
        }
        
        if let metadata = metadata?.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        
        return try StripeRequest(client: self.client, method: .post, route: .coupons, query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Retrieve a coupon
     Retrieves the coupon with the given ID.
     
     - parameter couponId: The ID of the desired coupon.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func retrieve(coupon couponId: String) throws -> StripeRequest<Coupon> {
        return try StripeRequest(client: self.client, method: .get, route: .coupon(couponId), query: [:], body: nil, headers: nil)
    }
    
    /**
     Update a coupon
     Updates the metadata of a coupon. Other coupon details (currency, duration, amount_off) are, by design, not editable.
     
     - parameter couponId: The identifier of the coupon to be updated.
     
     - parameter metaData: A set of key/value pairs that you can attach to a coupon object. It can be useful for storing additional 
                           information about the coupon in a structured format (Non optional since it's the only mutable property)
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func update(metadata: Node, forCouponId couponId: String) throws -> StripeRequest<Coupon> {
        var body = Node([:])
        
        if let metadata = metadata.object {
            for (key, value) in metadata {
                body["metadata[\(key)]"] = value
            }
        }
        return try StripeRequest(client: self.client, method: .post, route: .coupon(couponId), query: [:], body: Body.data(body.formURLEncoded()), headers: nil)
    }
    
    /**
     Delete a coupon
     Deletes the coupon with the given ID.
     
     - parameter couponId: The identifier of the coupon to be deleted.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func delete(coupon couponId: String) throws -> StripeRequest<DeletedObject> {
        return try StripeRequest(client: self.client, method: .delete, route: .coupon(couponId), query: [:], body: nil, headers: nil)
    }
    
    /**
     List all coupons
     Returns a list of your coupons. The coupons are returned sorted by creation date, with the
     most recent coupons appearing first.
     
     - parameter filter: A Filter item to pass query parameters when fetching results.
     
     - returns: A StripeRequest<> item which you can then use to convert to the corresponding node
     */
    
    public func listAll(filter: StripeFilter?) throws -> StripeRequest<CouponList> {
        var query = [String : NodeRepresentable]()
        
        if let data = try filter?.createQuery()
        {
            query = data
        }
        return try StripeRequest(client: self.client, method: .get, route: .coupons, query: query, body: nil, headers: nil)
    }
}
