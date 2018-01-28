//
////  CouponTests.swift
////  Stripe
////
////  Created by Andrew Edwards on 5/28/17.
////
////
//
//import XCTest
//
//@testable import Stripe
//@testable import Vapor
//
//
//
//
//
//class CouponTests: XCTestCase {
//    var drop: Droplet?
//    var couponId: String = ""
//    
//    override func setUp() {
//        do {
//            drop = try self.makeDroplet()
//            
//            couponId = try drop?.stripe?.coupons.create(id: nil,
//                                                        duration: .once,
//                                                        amountOff: 5,
//                                                        currency: .usd,
//                                                        durationInMonths: nil,
//                                                        maxRedemptions: 5,
//                                                        percentOff: nil,
//                                                        redeemBy: Date().addingTimeInterval(3000),
//                                                        metadata: ["meta":"data"]).serializedResponse().id ?? ""
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            fatalError("Setup failed: \(error.localizedDescription)")
//        }
//    }
//    override func tearDown() {
//        drop = nil
//        couponId = ""
//    }
//    
//    func testCreateCoupon() throws {
//        do {
//            let coupon = try drop?.stripe?.coupons.create(id: nil,
//                                                          duration: .once,
//                                                          amountOff: 5,
//                                                          currency: .usd,
//                                                          durationInMonths: nil,
//                                                          maxRedemptions: 5,
//                                                          percentOff: nil,
//                                                          redeemBy: Date().addingTimeInterval(3000),
//                                                          metadata: ["meta":"data"]).serializedResponse()
//            XCTAssertNotNil(coupon)
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testRetrieveCoupon() throws {
//        do {
//            let coupon = try drop?.stripe?.coupons.retrieve(coupon: couponId).serializedResponse()
//            
//            XCTAssertNotNil(coupon)
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testUpdateCoupon() throws {
//        
//        do {
//            let metadata = try Node(node:["hello":"world"])
//            let updatedCoupon = try drop?.stripe?.coupons.update(metadata: metadata, forCouponId: couponId).serializedResponse()
//            
//            XCTAssertNotNil(updatedCoupon)
//            
//            XCTAssertEqual(updatedCoupon?.metadata?["hello"], metadata["hello"])
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testDeleteCoupon() throws {
//        do {
//            let deletedCoupon = try drop?.stripe?.coupons.delete(coupon: couponId).serializedResponse()
//            
//            XCTAssertNotNil(deletedCoupon)
//            
//            XCTAssertTrue(deletedCoupon?.deleted ?? false)
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testListAllCoupons() throws {
//        do {
//            let coupons = try drop?.stripe?.coupons.listAll(filter: nil).serializedResponse()
//            
//            XCTAssertNotNil(coupons)
//            
//            if let couponItems = coupons?.items {
//                XCTAssertGreaterThanOrEqual(couponItems.count, 1)
//            } else {
//                XCTFail("Coupons are not present")
//            }
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testFilterCoupons() throws {
//        do {
//            let filter = StripeFilter()
//            
//            filter.limit = 1
//            
//            let coupons = try drop?.stripe?.coupons.listAll(filter: filter).serializedResponse()
//            
//            XCTAssertNotNil(coupons)
//            
//            if let couponItems = coupons?.items {
//                XCTAssertEqual(couponItems.count, 1)
//            } else {
//                XCTFail("Coupons are not present")
//            }
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//}

