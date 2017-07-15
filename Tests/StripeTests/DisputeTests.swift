//
//  DisputeTests.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/12/17.
//
//

import XCTest

@testable import Stripe
@testable import Vapor
@testable import Models
@testable import API
@testable import Errors
@testable import Helpers

class DisputeTests: XCTestCase {

    var drop: Droplet?
    var disputeId: String = ""
    
    override func setUp() {
        do {
            drop = try self.makeDroplet()
            
            let customer = try drop?.stripe?.customer.create(accountBalance: nil,
                                                           businessVATId: nil,
                                                           coupon: nil,
                                                           defaultSource: nil,
                                                           description: "Vapor test Account",
                                                           email: "vapor@stripetest.com",
                                                           shipping: nil,
                                                           source: nil,
                                                           metadata: nil).serializedResponse()
            
            let card = Node(["number":"4000 0000 0000 0259", "cvc":123,"exp_month":10, "exp_year":2020])
            
            let sourceId = try drop?.stripe?.sources.createNewSource(sourceType: .card,
                                                                 source: card,
                                                                 amount: nil,
                                                                 currency: .usd,
                                                                 flow: nil,
                                                                 owner: nil,
                                                                 redirectReturnUrl: nil,
                                                                 token: nil,
                                                                 usage: nil,
                                                                 metadata: nil).serializedResponse().id ?? ""
            
            _ = try drop?.stripe?.customer.addNewSource(forCustomer: customer?.id ?? "",
                                                        inConnectAccount: nil,
                                                        source: sourceId).serializedResponse()
            
            let chargeId = try drop?.stripe?.charge.create(amount: 10_00,
                                                         in: .usd,
                                                         withFee: nil,
                                                         toAccount: nil,
                                                         capture: true,
                                                         description: "Vapor Stripe: Test Description",
                                                         destinationAccountId: nil,
                                                         destinationAmount: nil,
                                                         transferGroup: nil,
                                                         onBehalfOf: nil,
                                                         receiptEmail: nil,
                                                         shippingLabel: nil,
                                                         customer: customer?.id ?? "",
                                                         statementDescriptor: nil,
                                                         source: nil,
                                                         metadata: nil).serializedResponse().id ?? ""
            
            disputeId = try drop?.stripe?.charge.retrieve(charge: chargeId).serializedResponse().dispute ?? ""
            
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
        disputeId = ""
    }

    func testRetrieveDispute() throws {
        do {
            let dispute = try drop?.stripe?.disputes.retrieve(dispute: disputeId).serializedResponse()
            XCTAssertNotNil(dispute)
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
    
    func testUpdateDispute() throws {
        do {
            let evidence = Node([
                "customer_name": "Mr. Vapor",
                "refund_refusal_explanation": "Because we need the money",
                "cancellation_rebuttal": "I have no further comments",
            ])
            
            let updatedDispute = try drop?.stripe?.disputes.update(dispute: disputeId, evidence: evidence, submit: true).serializedResponse()
            
            XCTAssertNotNil(updatedDispute)
            
            XCTAssertEqual(updatedDispute?.evidence?.customerName, "Mr. Vapor")
            XCTAssertEqual(updatedDispute?.evidence?.refundRefusalExplination, "Because we need the money")
            XCTAssertEqual(updatedDispute?.evidence?.cancellationRebuttal, "I have no further comments")
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
    
    func testCloseDispute() throws {
        do {
            let closedDispute = try drop?.stripe?.disputes.close(dispute: disputeId).serializedResponse()
            
            XCTAssertNotNil(closedDispute)
            
            XCTAssertEqual(closedDispute?.disputeStatus, .lost)
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
    
    func testListAllDisputes() throws {
        do {
            let disputes = try drop?.stripe?.account.listAll().serializedResponse()
            
            XCTAssertNotNil(disputes)
            
            if let disputeItems = disputes?.items {
                XCTAssertGreaterThanOrEqual(disputeItems.count, 1)
            } else {
                XCTFail("Disputes are not present")
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
    
    func testFilterDisputes() throws {
        do {
            let filter = StripeFilter()
            
            filter.limit = 1
            
            let disputes = try drop?.stripe?.account.listAll(filter: filter).serializedResponse()
            
            XCTAssertNotNil(disputes)
            
            if let disputeItems = disputes?.items {
                XCTAssertEqual(disputeItems.count, 1)
            } else {
                XCTFail("Disputes are not present")
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
