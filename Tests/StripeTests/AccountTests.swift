//
//  AccountTests.swift
//  Stripe
//
//  Created by Andrew Edwards on 7/9/17.
//
//

import XCTest

@testable import Stripe
@testable import Vapor
@testable import Models
@testable import API
@testable import Errors
@testable import Helpers

class AccountTests: XCTestCase {
    
    var drop: Droplet?
    var accountId: String = ""
    
    override func setUp() {
        do {
            drop = try self.makeDroplet()
            accountId = try drop?.stripe?.account.create(type: .custom,
                                                           email: "123@example.com",
                                                           country: "US").serializedResponse().id ?? ""
            
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
        accountId = ""
    }
    
    func testCreateAccount() throws {
        
        // Only test with custom accounts because standard cannot reuse same email and test will fail. 
        do {
            let account = try drop?.stripe?.account.create(type: .custom,
                                                           email: "123@example.com",
                                                           country: "US").serializedResponse()
            
            XCTAssertNotNil(account)
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
    
    func testRetrieveAccount() throws {
        do {
            let retrievedAccount = try drop?.stripe?.account.retrieve(account: accountId).serializedResponse()
            
            XCTAssertNotNil(retrievedAccount)
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
    
    func testUpdateAccount() throws {
        
        do {
            let businessname = "Vapor Meals"
            
            let declineChargeOn = Node([
                    "avs_failure": true,
                    "cvc_failure": false
                ])
            
            let externalAccount = Node([
                    "object": "bank_account",
                    "account_number": "000123456789",
                    "country": "US",
                    "currency": "usd",
                    "account_holder_name": "Mr. Vapor",
                    "account_holder_type": "individual",
                    "routing_number": "110000000"
                ])
            
            let payoutSchedule = Node([
                    "delay_days": 4,
                    "interval": "weekly",
                    "weekly_anchor": "friday"
                ])
            
            let tosAcceptance = Node([
                    "date": 1499627823,
                    "ip": "0.0.0.0",
                    "user_agent": "Safari"
                ])
            
            let metadata = Node(["hello":"world"])
            
            let updatedAccount = try drop?.stripe?.account.update(account: accountId,
                                                                  businessName: businessname,
                                                                  businessPrimaryColor: nil,
                                                                  businessUrl: nil,
                                                                  debitNegativeBalances: false,
                                                                  declineChargeOn: declineChargeOn,
                                                                  defaultCurrency: .usd,
                                                                  email: nil,
                                                                  externalAccount: externalAccount,
                                                                  legalEntity: nil,
                                                                  payoutSchedule: payoutSchedule,
                                                                  payoutStatementDescriptor: nil,
                                                                  productDescription: nil,
                                                                  statementDescriptor: nil,
                                                                  supportEmail: nil,
                                                                  supportPhone: nil,
                                                                  supportUrl: nil,
                                                                  tosAcceptance: tosAcceptance,
                                                                  metadata: metadata).serializedResponse()
            // TODO - Add test for legal entity
            
            XCTAssertNotNil(updatedAccount)
            
            XCTAssertEqual(updatedAccount?.businessName, businessname)
            
            XCTAssertEqual(updatedAccount?.declineChargeOn?["avs_failure"], true)
            
            XCTAssertEqual(updatedAccount?.declineChargeOn?["cvc_failure"], false)
            
            XCTAssertEqual(updatedAccount?.externalAccounts?.bankAccounts[0].accountHolderName,  "Mr. Vapor")
            
            XCTAssertEqual(updatedAccount?.externalAccounts?.bankAccounts[0].currency,  StripeCurrency.usd)
            
            XCTAssertEqual(updatedAccount?.externalAccounts?.bankAccounts[0].accountHolderType,  "individual")
            
            XCTAssertEqual(updatedAccount?.payoutSchedule?.interval, .weekly)
            
            XCTAssertEqual(updatedAccount?.payoutSchedule?.weeklyAnchor, .friday)
            
            XCTAssertEqual(updatedAccount?.payoutSchedule?.delayDays, 4)

            XCTAssertEqual(updatedAccount?.tosAcceptance?.ip, "0.0.0.0")
            
            XCTAssertEqual(updatedAccount?.tosAcceptance?.userAgent, "Safari")
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
    
    func testDeleteAccount() throws {
        do {
            let deletedAccount = try drop?.stripe?.account.delete(account: accountId).serializedResponse()
            
            XCTAssertNotNil(deletedAccount)
            
            XCTAssertEqual(deletedAccount?.deleted, true)
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
    
    func testRejectAccount() throws {
        
        do {
            let rejectedAccount = try drop?.stripe?.account.reject(account: accountId, for: .fraud).serializedResponse()
            
            XCTAssertNotNil(rejectedAccount)
            
            XCTAssertEqual(rejectedAccount?.chargesEnabled, false)
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
    
    /*func testCreateLoginLink() throws {
        do {
            // make account express account
            let loginLink = try drop?.stripe?.account.createLoginLink(forAccount: accountId).serializedResponse()
            
            XCTAssertNotNil(loginLink)
            
            XCTAssertNotNil(loginLink?.url)
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
    }*/
    
    func testListAllAccounts() throws {
        do {
            let accounts = try drop?.stripe?.account.listAll().serializedResponse()
            
            XCTAssertNotNil(accounts)
            
            if let accountItems = accounts?.items {
                XCTAssertGreaterThanOrEqual(accountItems.count, 1)
            } else {
                XCTFail("Accounts are not present")
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
    
    func testFilterAccounts() throws {
        do {
            let filter = StripeFilter()
            
            filter.limit = 1
            
            let accounts = try drop?.stripe?.account.listAll(filter: filter).serializedResponse()
            
            XCTAssertNotNil(accounts)
            
            if let accountItems = accounts?.items {
                XCTAssertEqual(accountItems.count, 1)
            } else {
                XCTFail("Accounts are not present")
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
