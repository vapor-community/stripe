//
//  PlanTests.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/17.
//
//

import XCTest
import Foundation

@testable import Stripe
@testable import Vapor
@testable import Helpers
@testable import API
@testable import Models
@testable import Errors
@testable import Random

class PlanTests: XCTestCase {
    var drop: Droplet?
    var planId: String = ""
    
    override func setUp() {
        do {
            drop = try self.makeDroplet()
            
            planId = try drop?.stripe?.plans.create(id: Data(bytes: URandom.bytes(count: 16)).base64String,
                                                    amount: 10_00,
                                                    currency: .usd,
                                                    interval: .week,
                                                    name: "Test Plan",
                                                    intervalCount: 5,
                                                    statementDescriptor: "Test Plan",
                                                    trialPeriodDays: nil,
                                                    metadata: nil)
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
        planId = ""
    }
    
    func testCreatePlan() throws {
        do {
            let plan = try drop?.stripe?.plans.create(id: Data(bytes: URandom.bytes(count: 16)).base64String,
                                                                 amount: 10_00,
                                                                 currency: .usd,
                                                                 interval: .week,
                                                                 name: "Test Plan",
                                                                 intervalCount: 5,
                                                                 statementDescriptor: "Test Plan",
                                                                 trialPeriodDays: nil,
                                                                 metadata: nil)
                                                                 .serializedResponse().id ?? ""
            XCTAssertNotNil(plan)
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
    
    func testRetrievePlan() throws {
        do {
            let plan = try drop?.stripe?.plans.retrieve(plan: planId)
            
            XCTAssertNotNil(plan)
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
    
    func testUpdatePlan() throws {
        do {
            let metadata = try Node(node:["hello":"world"])
            let newName = "Super plan"
            let newStatementDescriptor = "Super descriptor"
            let trialDays = 30
            
            let updatedPlan = try drop?.stripe?.plans.update(name: newName,
                                                            statementDescriptor: newStatementDescriptor,
                                                            trialPeriodDays: trialDays,
                                                            metadata: metadata,
                                                            forPlanId: planId)
                                                            .serializedResponse()
            
            XCTAssertNotNil(updatedPlan)
            
            XCTAssertEqual(updatedPlan?.metadata?["hello"], metadata["hello"])
            
            XCTAssertEqual(updatedPlan?.name, newName)
            
            XCTAssertEqual(updatedPlan?.statementDescriptor, newStatementDescriptor)
            
            XCTAssertEqual(updatedPlan?.trialPeriodDays, trialDays)
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
    
    func testDeletePlan() throws {
        do {
            let deletedPlan = try drop?.stripe?.plans.delete(plan: planId).serializedResponse()
            
            XCTAssertNotNil(deletedPlan)
            
            XCTAssertTrue(deletedPlan?.deleted ?? false)
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
    
    func testListAllPlans() throws {
        do {
            let plans = try drop?.stripe?.plans.listAll(filter: nil).serializedResponse()
            
            XCTAssertNotNil(plans)
            
            if let planItems = plans?.items {
                XCTAssertGreaterThanOrEqual(planItems.count, 1)
            } else {
                XCTFail("Plans are not present")
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
    
    func testFilterPlans() throws {
        do {
            let filter = StripeFilter()
            
            filter.limit = 1
            
            let plans = try drop?.stripe?.plans.listAll(filter: filter).serializedResponse()
            
            XCTAssertNotNil(plans)
            
            if let planItems = plans?.items {
                XCTAssertEqual(planItems.count, 1)
            } else {
                XCTFail("Plans are not present")
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
