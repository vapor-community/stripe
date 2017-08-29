//
//  SubscriptionTests.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/10/17.
//
//

import XCTest

@testable import Stripe
@testable import Vapor




@testable import Random

class SubscriptionTests: XCTestCase {
    
    var drop: Droplet?
    var subscriptionId: String = ""
    
    override func setUp() {
        do {
            drop = try self.makeDroplet()
            
            let planId = try drop?.stripe?.plans.create(id: Data(bytes: URandom.bytes(count: 16)).base64String,
                                                        amount: 10_00,
                                                        currency: .usd,
                                                        interval: .week,
                                                        name: "Test Plan",
                                                        intervalCount: 5,
                                                        statementDescriptor: "Test Plan",
                                                        trialPeriodDays: nil,
                                                        metadata: nil)
                                                        .serializedResponse().id ?? ""
            
            let paymentTokenSource = try drop?.stripe?.tokens.createCardToken(withCardNumber: "4242 4242 4242 4242",
                                                                              expirationMonth: 10,
                                                                              expirationYear: 2018,
                                                                              cvc: 123,
                                                                              name: "Test Card",
                                                                              customer: nil,
                                                                              currency: nil)
                                                                              .serializedResponse().id ?? ""
            
            let customerId = try drop?.stripe?.customer.create(accountBalance: nil,
                                                               businessVATId: nil,
                                                               coupon: nil,
                                                               defaultSource: nil,
                                                               description: nil,
                                                               email: nil,
                                                               shipping: nil,
                                                               source: paymentTokenSource)
                                                               .serializedResponse().id ?? ""
            
            subscriptionId = try drop?.stripe?.subscriptions.create(forCustomer: customerId,
                                                                    plan: planId,
                                                                    applicationFeePercent: nil,
                                                                    couponId: nil,
                                                                    items: nil,
                                                                    quantity: nil,
                                                                    source: nil,
                                                                    taxPercent: nil,
                                                                    trialEnd: nil,
                                                                    trialPeriodDays: nil)
                                                                    .serializedResponse().id ?? ""
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    override func tearDown() {
        drop = nil
        subscriptionId = ""
    }
    
    func testRetrieveSubscription() throws {
        do {
            let subscription = try drop?.stripe?.subscriptions.retrieve(subscription: subscriptionId).serializedResponse()
            
            XCTAssertNotNil(subscription)
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testUpdateSubscription() throws {
        do {
            let newQuantity = 2
            
            let updatedSubscription = try drop?.stripe?.subscriptions.update(subscription: subscriptionId,
                                                                                 applicationFeePercent: nil,
                                                                                 couponId: nil,
                                                                                 items: nil,
                                                                                 plan: nil,
                                                                                 prorate: nil,
                                                                                 quantity: newQuantity,
                                                                                 source: nil,
                                                                                 taxPercent: nil,
                                                                                 trialEnd: nil)
                                                                                 .serializedResponse()

            XCTAssertNotNil(updatedSubscription)
            
            XCTAssertEqual(updatedSubscription?.quantity, newQuantity)
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
   
    func testDeleteDiscount() throws {
        do {
            let couponId = try drop?.stripe?.coupons.create(id: nil,
                                                            duration: .once,
                                                            amountOff: nil,
                                                            currency: nil,
                                                            durationInMonths: nil,
                                                            maxRedemptions: nil,
                                                            percentOff: 5,
                                                            redeemBy: nil)
                                                            .serializedResponse().id ?? ""
            
            let updatedSubscription = try drop?.stripe?.subscriptions.update(subscription: subscriptionId,
                                                                             applicationFeePercent: nil,
                                                                             couponId: couponId,
                                                                             items: nil,
                                                                             plan: nil,
                                                                             prorate: nil,
                                                                             quantity: nil,
                                                                             source: nil,
                                                                             taxPercent: nil,
                                                                             trialEnd: nil)
                                                                             .serializedResponse()
            
            XCTAssertNotNil(updatedSubscription?.discount)
            
            let deletedDiscount = try drop?.stripe?.subscriptions.deleteDiscount(onSubscription: updatedSubscription?.id ?? "").serializedResponse()
            
            XCTAssertTrue(deletedDiscount?.deleted ?? false)
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testCancelSubscription() throws {
        do {
            let canceledSubscription = try drop?.stripe?.subscriptions.cancel(subscription: subscriptionId, atPeriodEnd: false).serializedResponse()
            
            XCTAssertNotNil(canceledSubscription)
            
            XCTAssertTrue(canceledSubscription?.status == StripeSubscriptionStatus.canceled)
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testFilterSubscriptionItems() throws {
        do {
            let filter = StripeFilter()
            
            filter.limit = 1
            
            let subscriptions = try drop?.stripe?.subscriptions.listAll(filter: filter).serializedResponse()
            
            XCTAssertNotNil(subscriptions)
            
            if let subscriptionItems = subscriptions?.items {
                XCTAssertEqual(subscriptionItems.count, 1)
                XCTAssertNotNil(subscriptionItems.first)
            } else {
                XCTFail("Subscriptions are not present")
            }
        }
        catch let error as StripeError {
            
            switch error {
            case .apiConnectionError:
                XCTFail(error.localizedDescription)
            case .apiError:
                XCTFail(error.localizedDescription)
            case .authenticationError:
                XCTFail(error.localizedDescription)
            case .cardError:
                XCTFail(error.localizedDescription)
            case .invalidRequestError:
                XCTFail(error.localizedDescription)
            case .rateLimitError:
                XCTFail(error.localizedDescription)
            case .validationError:
                XCTFail(error.localizedDescription)
            case .invalidSourceType:
                XCTFail(error.localizedDescription)
            default:
                XCTFail(error.localizedDescription)
            }
        }
        catch {
            XCTFail(error.localizedDescription)
        }
    }
}
