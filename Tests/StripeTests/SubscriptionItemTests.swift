////
////  SubscriptionItemTests.swift
////  Stripe
////
////  Created by Andrew Edwards on 6/9/17.
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
//@testable import Random
//
//class SubscriptionItemTests: XCTestCase {
//    var drop: Droplet?
//    var subscriptionId: String = ""
//    var subscriptionItemId: String = ""
//    
//    override func setUp() {
//        do {
//            drop = try self.makeDroplet()
//            
//            let planId = try drop?.stripe?.plans.create(id: Data(bytes: URandom.bytes(count: 16)).base64String,
//                                                        amount: 10_00,
//                                                        currency: .usd,
//                                                        interval: .week,
//                                                        name: "Test Plan",
//                                                        intervalCount: 5,
//                                                        statementDescriptor: "Test Plan",
//                                                        trialPeriodDays: nil,
//                                                        metadata: nil)
//                                                        .serializedResponse().id ?? ""
//            
//            let paymentTokenSource = try drop?.stripe?.tokens.createCardToken(withCardNumber: "4242 4242 4242 4242",
//                                                                              expirationMonth: 10,
//                                                                              expirationYear: 2018,
//                                                                              cvc: 123,
//                                                                              name: "Test Card",
//                                                                              customer: nil,
//                                                                              currency: nil)
//                                                                              .serializedResponse().id ?? ""
//            
//            let customerId = try drop?.stripe?.customer.create(accountBalance: nil,
//                                                               businessVATId: nil,
//                                                               coupon: nil,
//                                                               defaultSource: nil,
//                                                               description: nil,
//                                                               email: nil,
//                                                               shipping: nil,
//                                                               source: paymentTokenSource).serializedResponse().id ?? ""
//            
//            subscriptionId = try drop?.stripe?.subscriptions.create(forCustomer: customerId,
//                                                                    plan: planId,
//                                                                    applicationFeePercent: nil,
//                                                                    couponId: nil,
//                                                                    items: nil,
//                                                                    quantity: nil,
//                                                                    source: nil,
//                                                                    taxPercent: nil,
//                                                                    trialEnd: nil,
//                                                                    trialPeriodDays: nil)
//                                                                    .serializedResponse().id ?? ""
//            
//            let planId2 = try drop?.stripe?.plans.create(id: Data(bytes: URandom.bytes(count: 16)).base64String,
//                                                        amount: 10_00,
//                                                        currency: .usd,
//                                                        interval: .week,
//                                                        name: "Test Plan",
//                                                        intervalCount: 5,
//                                                        statementDescriptor: "Test Plan",
//                                                        trialPeriodDays: nil,
//                                                        metadata: nil)
//                                                        .serializedResponse().id ?? ""
//            
//            subscriptionItemId = try drop?.stripe?.subscriptionItems.create(planId: planId2,
//                                                                            prorate: true,
//                                                                            prorationDate: Date(),
//                                                                            quantity: 1,
//                                                                            subscriptionId: subscriptionId)
//                                                                            .serializedResponse().id ?? ""
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
//    
//    override func tearDown() {
//        drop = nil
//        subscriptionId = ""
//        subscriptionItemId = ""
//    }
//    
//    func testRetrieveSubscriptionItem() throws {
//        do {
//            let subscriptionItem = try drop?.stripe?.subscriptionItems.retrieve(subscriptionItem: subscriptionItemId).serializedResponse()
//            
//            XCTAssertNotNil(subscriptionItem)
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
//    func testUpdateSubscriptionItem() throws {
//        do {
//            let newQuantity = 2
//            
//            let updatedSubscriptionItem = try drop?.stripe?.subscriptionItems.update(plan: nil,
//                                                                                     prorate: nil,
//                                                                                     prorationDate: nil,
//                                                                                     quantity: newQuantity,
//                                                                                     subscriptionItemId: subscriptionItemId)
//                                                                                     .serializedResponse()
//            
//            XCTAssertNotNil(updatedSubscriptionItem)
//            
//            XCTAssertEqual(updatedSubscriptionItem?.quantity, newQuantity)
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
//    func testDeleteSubscriptionItem() throws {
//        do {
//            let deletedSubscriptionItem = try drop?.stripe?.subscriptionItems.delete(subscriptionItem: subscriptionItemId,
//                                                                                     prorate: nil,
//                                                                                     proprationDate: nil).serializedResponse()
//            
//            XCTAssertNotNil(deletedSubscriptionItem)
//            
//            XCTAssertTrue(deletedSubscriptionItem?.deleted ?? false)
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
//    func testFilterSubscriptionItems() throws {
//        do {
//            let filter = StripeFilter()
//            
//            filter.limit = 1
//
//            let subscriptionItems = try drop?.stripe?.subscriptionItems.listAll(subscriptionId: subscriptionId, filter: filter).serializedResponse()
//            
//            XCTAssertNotNil(subscriptionItems)
//            
//            if let subscriptionItems = subscriptionItems?.items {
//                XCTAssertEqual(subscriptionItems.count, 1)
//                XCTAssertNotNil(subscriptionItems.first)
//            } else {
//                XCTFail("SubscriptionItems are not present")
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

