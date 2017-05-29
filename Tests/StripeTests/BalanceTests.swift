//
//  BalanceTests.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/14/17.
//
//

import XCTest

@testable import Stripe
@testable import Vapor
@testable import API

class BalanceTests: XCTestCase {

    var drop: Droplet?
    var transactionId: String = ""
    
    override func setUp()
    {
        do
        {
            drop = try self.makeDroplet()
            
            let paymentToken = try drop?.stripe?.tokens.createCard(withCardNumber: "4242 4242 4242 4242",
                                                             expirationMonth: 10,
                                                             expirationYear: 2018,
                                                             cvc: 123,
                                                             name: "Test Card")
                                                            .serializedResponse().id ?? ""
            
            transactionId = try drop?.stripe?.charge.create(amount: 10_00,
                                                         in: .usd,
                                                         for: .source(paymentToken),
                                                         description: "Vapor Stripe: Test Description")
                                                        .serializedResponse()
                                                        .balanceTransactionId ?? ""
        }
        catch
        {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    func testBalance() throws {
        let object = try drop?.stripe?.balance.retrieveBalance().serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testBalanceTransactionItem() throws
    {
        let object = try drop?.stripe?.balance.retrieveBalance(forTransaction: transactionId).serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testBalanceHistory() throws {
        let drop = try self.makeDroplet()
        let object = try drop.stripe?.balance.history().serializedResponse()
        XCTAssertNotNil(object)
    }
    
    func testFilterBalanceHistory() throws {
        let drop = try self.makeDroplet()
        let filter = StripeFilter()
        filter.limit = 1
        let object = try drop.stripe?.balance.history(forFilter: filter).serializedResponse()
        XCTAssertEqual(object?.items.count, 1)
    }
}
