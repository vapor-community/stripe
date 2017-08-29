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



class BalanceTests: XCTestCase {

    var drop: Droplet?
    var transactionId: String = ""
    
    override func setUp() {
        do {
            drop = try self.makeDroplet()
            
            let paymentToken = try drop?.stripe?.tokens.createCardToken(withCardNumber: "4242 4242 4242 4242",
                                                             expirationMonth: 10,
                                                             expirationYear: 2018,
                                                             cvc: 123,
                                                             name: "Test Card",
                                                             customer: nil,
                                                             currency: nil)
                                                            .serializedResponse().id ?? ""
            
            transactionId = try drop?.stripe?.charge.create(amount: 10_00,
                                                            in: .usd,
                                                            withFee: nil,
                                                            toAccount: nil,
                                                           capture: nil,
                                                           description: "Vapor Stripe: Test Description",
                                                           destinationAccountId: nil,
                                                           destinationAmount: nil,
                                                           transferGroup: nil,
                                                           onBehalfOf: nil,
                                                           receiptEmail: nil,
                                                           shippingLabel: nil,
                                                           customer: nil,
                                                           statementDescriptor: nil,
                                                           source: paymentToken,
                                                           metadata: nil)
                                                           .serializedResponse().balanceTransactionId ?? ""
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
        transactionId = ""
    }
    
    func testBalance() throws {
        
        do {
            let object = try drop?.stripe?.balance.retrieveBalance().serializedResponse()
            XCTAssertNotNil(object)
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
    
    func testBalanceTransactionItem() throws {
        do {
            let object = try drop?.stripe?.balance.retrieveBalanceTransaction(transactionId).serializedResponse()
            XCTAssertNotNil(object)
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
    
    func testBalanceHistory() throws {
        do {
            let object = try drop?.stripe?.balance.history(forFilter: nil).serializedResponse()
            XCTAssertNotNil(object)
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
    
    func testFilterBalanceHistory() throws {
        
        do {
            let filter = StripeFilter()
            filter.limit = 1
            let balance = try drop?.stripe?.balance.history(forFilter: filter).serializedResponse()
            
            if let balances = balance?.items {
                XCTAssertEqual(balances.count, 1)
            } else {
                XCTFail("Balances are not present")
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
