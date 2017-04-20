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
    
    static var allTests = [
        ("testCreateCustomer ", testCreateCustomer),
        ("testRetrieveCustomer", testRetrieveCustomer),
        ("testUpdateCustomer", testUpdateCustomer),
        ("testDeleteCustomer", testDeleteCustomer),
        ("testRetrieveAllCustomers", testRetrieveAllCustomers),
        ("testFilterCustomers", testFilterCustomers)
    ]
    
    func testCreateCustomer() throws {
        let drop = try self.makeDroplet()
        let customer = Customer()
        customer.email = "test@stripetest.com"
        customer.description = "This is a test customer"
        let object = try drop.stripe?.customer.create(customer: customer).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testRetrieveCustomer() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.customer.retrieve(customer: TestCustomerID).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testUpdateCustomer() throws {
        let drop = try self.makeDroplet()
        let customer = Customer()
        customer.email = "test@stripetest.com"
        customer.description = "This is a test customer updated"
        let object = try drop.stripe?.customer.update(customer: customer, forCustomerId: TestCustomerID).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testDeleteCustomer() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.customer.delete(customer: TestCustomerID).serializedResponse()
        XCTAssertEqual(object?.deleted, true)
    }
    
    func testRetrieveAllCustomers() throws {
        let drop = try self.makeDroplet()
        let customer = Customer()
        customer.email = "test@stripetest.com"
        customer.description = "This is a test customer updated"
        let object = try drop.stripe?.customer.listAll().serializedResponse()
        XCTAssertGreaterThanOrEqual(object!.items!.count, 1)
    }
    
    func testFilterCustomers() throws {
        let drop = try self.makeDroplet()
        let filter = Filter()
        filter.limit = 1
        let object = try drop.stripe?.customer.listAll(filter: filter).serializedResponse()
        XCTAssertEqual(object?.items?.count, 1)
    }
    
}
