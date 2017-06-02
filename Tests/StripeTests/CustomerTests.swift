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
            
            
            
            customerId = try drop?.stripe?.customer.create(accountBalance: nil,
                                                           businessVATId: nil,
                                                           coupon: nil,
                                                           defaultSource: nil,
                                                           description: "Vapor test Account",
                                                           email: "vapor@stripetest.com",
                                                           metadata: nil,
                                                           shipping: nil,
                                                           source: nil).serializedResponse().id ?? ""
        } catch {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    func testCreateCustomer() throws {
        
        let object = try drop?.stripe?.customer.create(accountBalance: nil,
                                                           businessVATId: nil,
                                                           coupon: nil,
                                                           defaultSource: nil,
                                                           description: "Vapor test Account",
                                                           email: "vapor@stripetest.com",
                                                           metadata: nil,
                                                           shipping: nil,
                                                           source: nil).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testRetrieveCustomer() throws {
        let object = try drop?.stripe?.customer.retrieve(customer: customerId).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testUpdateCustomer() throws {
        
        let updatedDescription = "Updated Vapor test Account"
        
        let updatedAccountBalance = 20_00
        
        let metadata = try Node(node:["hello":"world"])
        
        let updatedCustomer = try drop?.stripe?.customer.update(accountBalance: updatedAccountBalance,
                                                       businessVATId: nil,
                                                       coupon: nil,
                                                       defaultSourceId: nil,
                                                       description: updatedDescription,
                                                       email: nil,
                                                       metadata: metadata,
                                                       shipping: nil,
                                                       newSource: nil,
                                                       forCustomerId: customerId).serializedResponse()
        XCTAssertNotNil(updatedCustomer)
        
        XCTAssertEqual(updatedCustomer?.description, updatedDescription)
        
        XCTAssertEqual(updatedCustomer?.accountBalance, updatedAccountBalance)
        
        XCTAssertEqual(updatedCustomer?.metadata?["hello"], metadata["hello"])
    }
    
    func testAddNewSourceForCustomer() throws {
        
        let paymentTokenSource = try drop?.stripe?.tokens.createCardToken(withCardNumber: "4242 4242 4242 4242",
                                                                     expirationMonth: 10,
                                                                     expirationYear: 2018,
                                                                     cvc: 123,
                                                                     name: "Test Card",
                                                                     customer: nil,
                                                                     currency: nil)
                                                                     .serializedResponse().id ?? ""
        
        let newCardToken = try drop?.stripe?.customer.addNewSource(for: customerId,
                                                                      inConnectAccount: nil,
                                                                      source: paymentTokenSource)
                                                                      .serializedResponse()
        
        XCTAssertNotNil(newCardToken)
        
        let updatedCustomer = try drop?.stripe?.customer.retrieve(customer: customerId).serializedResponse()
        
        XCTAssertNotNil(updatedCustomer)
        
        let customerCardSource = updatedCustomer?.sources?.items?.filter { $0.id == newCardToken?.id}.first
        
        XCTAssertNotNil(customerCardSource)
        
        XCTAssertEqual(newCardToken?.id, customerCardSource?.id)
    }
    
    
    
    func testDeleteCustomer() throws {
        let object = try drop?.stripe?.customer.delete(customer: customerId).serializedResponse()
        XCTAssertEqual(object?.deleted, true)
    }
    
    func testRetrieveAllCustomers() throws {
        let object = try drop?.stripe?.customer.listAll(filter: nil).serializedResponse()
        XCTAssertGreaterThanOrEqual(object!.items!.count, 1)
    }
    
    func testFilterCustomers() throws {
        let filter = StripeFilter()
        filter.limit = 1
        let object = try drop?.stripe?.customer.listAll(filter: filter).serializedResponse()
        XCTAssertEqual(object?.items?.count, 1)
    }
}
