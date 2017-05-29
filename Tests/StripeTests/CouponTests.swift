//
//  CouponTests.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/28/17.
//
//

import XCTest

@testable import Stripe
@testable import Vapor
@testable import Helpers
@testable import API

class CouponTests: XCTestCase {
    var drop: Droplet?
    var couponId: String = ""
    
    override func setUp() {
        do {
            drop = try self.makeDroplet()
            
            couponId = try drop?.stripe?.coupons.create(id: nil,
                                                        duration: .once,
                                                        amountOff: 5,
                                                        currency: .usd,
                                                        durationInMonths: nil,
                                                        maxRedemptions: 5,
                                                        percentOff: nil,
                                                        redeemBy: Date().addingTimeInterval(3000),
                                                        metadata: ["meta":"data"]).serializedResponse().id ?? ""
        } catch {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    func testCreateCoupon() throws {
        let coupon = try drop?.stripe?.coupons.create(id: nil,
                                                      duration: .once,
                                                      amountOff: 5,
                                                      currency: .usd,
                                                      durationInMonths: nil,
                                                      maxRedemptions: 5,
                                                      percentOff: nil,
                                                      redeemBy: Date().addingTimeInterval(3000),
                                                      metadata: ["meta":"data"]).serializedResponse()
        XCTAssertNotNil(coupon)
    }
    
    func testRetrieveCoupon() throws {
        let coupon = try drop?.stripe?.coupons.retrieve(coupon: couponId).serializedResponse()
        
        XCTAssertNotNil(coupon)
    }
    
    func testUpdateCoupon() throws {
        let metadata = ["hello":"world"]
        let updatedCoupon = try drop?.stripe?.coupons.update(metadata: metadata, forCouponId: couponId).serializedResponse()
        
        XCTAssertNotNil(updatedCoupon)
        
        XCTAssert(updatedCoupon?.metadata?["hello"] == "world")
    }
    
    func testDeleteCoupon() throws {
        let deletedCoupon = try drop?.stripe?.coupons.delete(coupon: couponId).serializedResponse()
        
        XCTAssertNotNil(deletedCoupon)
        
        XCTAssertTrue(deletedCoupon?.deleted ?? false)
    }
    
    func testListAllCoupons() throws {
        let coupons = try drop?.stripe?.coupons.listAll().serializedResponse()
        
        XCTAssertNotNil(coupons)
        
        if let couponItems = coupons?.items {
            XCTAssertGreaterThanOrEqual(couponItems.count, 1)
        } else {
            XCTFail("Coupons are not present")
        }
    }
    
    func testFilterCoupons() throws {
        let filter = StripeFilter()
        
        filter.limit = 1
        
        let coupons = try drop?.stripe?.coupons.listAll(filter: filter).serializedResponse()
        
        XCTAssertNotNil(coupons)
        
        if let couponItems = coupons?.items {
            XCTAssertEqual(couponItems.count, 1)
        } else {
            XCTFail("Coupons are not present")
        }
    }
}
