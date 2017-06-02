//
//  PlanTests.swift
//  Stripe
//
//  Created by Andrew Edwards on 5/29/17.
//
//

import XCTest

@testable import Stripe
@testable import Vapor
@testable import Helpers
@testable import API
@testable import Models

class PlanTests: XCTestCase {
    var drop: Droplet?
    var planId: String = ""
    
    override func setUp() {
        do {
            drop = try self.makeDroplet()
            
            planId = try drop?.stripe?.plans.create(id: TestUtil.randomString(8),
                                                    amount: 10_00,
                                                    currency: .usd,
                                                    interval: .week,
                                                    name: "Test Plan",
                                                    intervalCount: 5,
                                                    metadata: nil,
                                                    statementDescriptor: "Test Plan",
                                                    trialPeriodDays: nil)
                                                    .serializedResponse().id ?? ""
        } catch {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    func testCreatePlan() throws {
        let plan = try drop?.stripe?.plans.create(id: TestUtil.randomString(8),
                                                             amount: 10_00,
                                                             currency: .usd,
                                                             interval: .week,
                                                             name: "Test Plan",
                                                             intervalCount: 5,
                                                             metadata: nil,
                                                             statementDescriptor: "Test Plan",
                                                             trialPeriodDays: nil)
                                                             .serializedResponse().id ?? ""
        XCTAssertNotNil(plan)
    }
    
    func testRetrievePlan() throws {
        let plan = try drop?.stripe?.plans.retrieve(plan: planId)
        
        XCTAssertNotNil(plan)
    }
    
    func testUpdatePlan() throws {
        
        let metadata = try Node(node:["hello":"world"])
        let newName = "Super plan"
        let newStatementDescriptor = "Super descriptor"
        let trialDays = 30
        
        let updatedPlan = try drop?.stripe?.plans.update(metadata: metadata,
                                                                name: newName,
                                                                statementDescriptor: newStatementDescriptor,
                                                                trialPeriodDays: trialDays, forPlanId: planId)
                                                                .serializedResponse()
        
        XCTAssertNotNil(updatedPlan)
        
        XCTAssertEqual(updatedPlan?.metadata?["hello"], metadata["hello"])
        
        XCTAssertEqual(updatedPlan?.name, newName)
        
        XCTAssertEqual(updatedPlan?.statementDescriptor, newStatementDescriptor)
        
        XCTAssertEqual(updatedPlan?.trialPeriodDays, trialDays)
    }
    
    func testDeletePlan() throws {
        let deletedPlan = try drop?.stripe?.plans.delete(plan: planId).serializedResponse()
        
        XCTAssertNotNil(deletedPlan)
        
        XCTAssertTrue(deletedPlan?.deleted ?? false)
    }
    
    func testListAllPlans() throws {
        let plans = try drop?.stripe?.plans.listAll(filter: nil).serializedResponse()
        
        XCTAssertNotNil(plans)
        
        if let planItems = plans?.items {
            XCTAssertGreaterThanOrEqual(planItems.count, 1)
        } else {
            XCTFail("Plans are not present")
        }
    }
    
    func testFilterPlans() throws {
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
}
