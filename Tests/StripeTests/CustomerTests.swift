//
//  CustomerTests.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/20/17.
//
//

import XCTest

@testable import Stripe
@testable import Vapor
@testable import Models
@testable import API

class CustomerTests: XCTestCase {
        
    var drop: Droplet?
    var customerId: String = ""
    
    override func setUp() {
        do {
            drop = try self.makeDroplet()
            
            let customer = Customer()
            
            customer.email = "test@stripetest.com"
            
            customer.description = "This is a test customer"
            
            customerId = try drop?.stripe?.customer.create(customer: customer).serializedResponse().id ?? ""
        } catch {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    func testCreateCustomer() throws {
        let customer = Customer()
        customer.email = "test@stripetest.com"
        customer.description = "This is a test customer"
        let object = try drop?.stripe?.customer.create(customer: customer).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testRetrieveCustomer() throws {
        let object = try drop?.stripe?.customer.retrieve(customer: customerId).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testUpdateCustomer() throws {
        let customer = Customer()
        customer.email = "tester@stripetest.com"
        customer.description = "This is a test customer updated"
        let object = try drop?.stripe?.customer.update(customer: customer, forCustomerId: customerId).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testDeleteCustomer() throws {
        let object = try drop?.stripe?.customer.delete(customer: customerId).serializedResponse()
        XCTAssertEqual(object?.deleted, true)
    }
    
    func testRetrieveAllCustomers() throws {
        let object = try drop?.stripe?.customer.listAll().serializedResponse()
        XCTAssertGreaterThanOrEqual(object!.items!.count, 1)
    }
    
    func testFilterCustomers() throws {
        let filter = StripeFilter()
        filter.limit = 1
        let object = try drop?.stripe?.customer.listAll(filter: filter).serializedResponse()
        XCTAssertEqual(object?.items?.count, 1)
    }
}
