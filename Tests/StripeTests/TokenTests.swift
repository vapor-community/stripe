//
//  TokenTests.swift
//  Stripe
//
//  Created by Anthony Castelli on 5/12/17.
//
//

import XCTest
@testable import Stripe
@testable import Vapor
@testable import Models
@testable import API
@testable import Errors

class TokenTests: XCTestCase {
    
    var drop: Droplet?
    var tokenId: String = ""
    
    override func setUp() {
        do {
            drop = try self.makeDroplet()
            
            tokenId = try drop?.stripe?.tokens.createCardToken(withCardNumber: "4242 4242 4242 4242",
                                                               expirationMonth: 10,
                                                               expirationYear: 2018,
                                                               cvc: 123,
                                                               name: "Test Card",
                                                               customer: nil,
                                                               currency: nil)
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
        tokenId = ""
    }
    
    func testCardTokenCreation() throws {
        do {
            let object = try drop?.stripe?.tokens.createCardToken(withCardNumber: "4242 4242 4242 4242",
                                                                  expirationMonth: 10,
                                                                  expirationYear: 2018,
                                                                  cvc: 123,
                                                                  name: "Test Card",
                                                                  customer: nil,
                                                                  currency: nil)
                                                                  .serializedResponse()
            XCTAssertNotNil(object?.card)
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
    
    func testTokenRetrieval() throws {
        do {
            let object = try drop?.stripe?.tokens.retrieve(tokenId).serializedResponse()
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
    
    func testBankAccountTokenCreation() throws {
        do {
            let object = try drop?.stripe?.tokens.createBankAccountToken(withAccountNumber: "000123456789",
                                                                         country: "US",
                                                                         currency: .usd,
                                                                         routingNumber: "110000000",
                                                                         accountHolderName: "Test Person",
                                                                         accountHolderType: "Individual",
                                                                         customer: nil).serializedResponse()
            XCTAssertNotNil(object?.bankAccount)
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
