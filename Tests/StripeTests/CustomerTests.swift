////
////  CustomerTests.swift
////  Stripe
////
////  Created by Anthony Castelli on 4/20/17.
////
////
//
//import XCTest
//
//@testable import Stripe
//@testable import Vapor
//
//
//
//
//
//class CustomerTests: XCTestCase {
//        
//    var drop: Droplet?
//    var customerId: String = ""
//    
//    override func setUp() {
//        do {
//            drop = try self.makeDroplet()
//            
//            customerId = try drop?.stripe?.customer.create(description: "Vapor test Account",
//                                                           email: "vapor@stripetest.com").serializedResponse().id ?? ""
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            fatalError("Setup failed: \(error.localizedDescription)")
//        }
//    }
//    
//    override func tearDown() {
//        drop = nil
//        customerId = ""
//    }
//    
//    func testCreateCustomer() throws {
//        do {
//            let object = try drop?.stripe?.customer.create(accountBalance: nil,
//                                                               businessVATId: nil,
//                                                               coupon: nil,
//                                                               defaultSource: nil,
//                                                               description: "Vapor test Account",
//                                                               email: "vapor@stripetest.com",
//                                                               shipping: nil,
//                                                               source: nil,
//                                                               metadata: nil).serializedResponse()
//            XCTAssertNotNil(object)
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testRetrieveCustomer() throws {
//        do {
//            let object = try drop?.stripe?.customer.retrieve(customer: customerId).serializedResponse()
//            XCTAssertNotNil(object)
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testUpdateCustomer() throws {
//        do {
//            let updatedDescription = "Updated Vapor test Account"
//            
//            let updatedAccountBalance = 20_00
//            
//            let metadata = try Node(node:["hello":"world"])
//            
//            let updatedCustomer = try drop?.stripe?.customer.update(accountBalance: updatedAccountBalance,
//                                                           businessVATId: nil,
//                                                           coupon: nil,
//                                                           defaultSourceId: nil,
//                                                           description: updatedDescription,
//                                                           email: nil,
//                                                           shipping: nil,
//                                                           newSource: nil,
//                                                           metadata: metadata,
//                                                           forCustomerId: customerId).serializedResponse()
//            XCTAssertNotNil(updatedCustomer)
//            
//            XCTAssertEqual(updatedCustomer?.description, updatedDescription)
//            
//            XCTAssertEqual(updatedCustomer?.accountBalance, updatedAccountBalance)
//            
//            XCTAssertEqual(updatedCustomer?.metadata?["hello"], metadata["hello"])
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testAddNewSourceForCustomer() throws {
//        do {
//            let card = Node(["number":"4242 4242 4242 4242", "cvc":123,"exp_month":10, "exp_year":2018])
//            
//            let cardSourceToken = try drop?.stripe?.sources.createNewSource(sourceType: .card,
//                                                                            source: card,
//                                                                            amount: nil,
//                                                                            currency: .usd,
//                                                                            flow: nil,
//                                                                            owner: nil,
//                                                                            redirectReturnUrl: nil,
//                                                                            token: nil,
//                                                                            usage: nil).serializedResponse().id ?? ""
//            
//            let newSource = try drop?.stripe?.customer.addNewSource(forCustomer: customerId,
//                                                                  inConnectAccount: nil,
//                                                                  source: cardSourceToken).serializedResponse()
//            
//            XCTAssertNotNil(newSource)
//            
//            let updatedCustomer = try drop?.stripe?.customer.retrieve(customer: customerId).serializedResponse()
//            
//            XCTAssertNotNil(updatedCustomer)
//            
//            let customerCardSource = updatedCustomer?.sources?.items?.filter { $0["id"]?.string == newSource?.id}.first
//            
//            XCTAssertNotNil(customerCardSource)
//            
//            XCTAssertEqual(newSource?.id, customerCardSource?["id"]?.string)
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testAddNewCardSourceForCustomer() throws {
//        do {
//            let card = Node( [
//                "object":"card",
//                "exp_month":10,
//                "exp_year": 2020,
//                "number": "4242 4242 4242 4242",
//                "address_city": "anytown",
//                "address_country": "US",
//                "address_line1": "123 main street",
//                "address_line2": "apt. 0",
//                "address_state": "NY",
//                "address_zip": "12345",
//                "currency": "usd",
//                "cvc": 123,
//                "default_for_currency": true,
//                "name": "Mr. Vapor Codes"
//                ])
//            
//            let newCard = try drop?.stripe?.customer.addNewCardSource(forCustomer: customerId,
//                                                                          inConnectAccount: nil,
//                                                                          source: card)
//                                                                          .serializedResponse()
//            
//            XCTAssertNotNil(newCard)
//            
//            let updatedCustomer = try drop?.stripe?.customer.retrieve(customer: customerId).serializedResponse()
//            
//            XCTAssertNotNil(updatedCustomer)
//            
//            let customerCardSource = updatedCustomer?.sources?.cardSources.filter { $0.id == newCard?.id}.first
//            
//            XCTAssertNotNil(customerCardSource)
//            
//            XCTAssertEqual(newCard?.id, customerCardSource?.id)
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testAddNewBankAccountSourceForCustomer() throws {
//        do {
//            let bankDetails: Node = Node([
//                "object":"bank_account",
//                "account_number": "000123456789",
//                "country": "US",
//                "currency": "usd",
//                "account_holder_name": "Mr. Vapor",
//                "account_holder_type": "individual",
//                "routing_number": "110000000"
//            ])
//            
//            let newBankToken = try drop?.stripe?.customer.addNewBankAccountSource(forCustomer: customerId,
//                                                                           inConnectAccount: nil,
//                                                                           source: bankDetails).serializedResponse()
//            
//            XCTAssertNotNil(newBankToken)
//            
//            let updatedCustomer = try drop?.stripe?.customer.retrieve(customer: customerId).serializedResponse()
//            
//            XCTAssertNotNil(updatedCustomer)
//            
//            let customerBankAccountSource = updatedCustomer?.sources?.bankSources.filter { $0.id == newBankToken?.id}.first
//            
//            XCTAssertNotNil(customerBankAccountSource)
//            
//            XCTAssertEqual(newBankToken?.id, customerBankAccountSource?.id)
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testDeleteDiscount() throws {
//        do {
//            let couponId = try drop?.stripe?.coupons.create(id: nil,
//                                                            duration: .once,
//                                                            amountOff: nil,
//                                                            currency: nil,
//                                                            durationInMonths: nil,
//                                                            maxRedemptions: nil,
//                                                            percentOff: 5,
//                                                            redeemBy: nil)
//                                                            .serializedResponse().id ?? ""
//            
//            let updatedCustomer = try drop?.stripe?.customer.update(accountBalance: nil,
//                                              businessVATId: nil,
//                                              coupon: couponId,
//                                              defaultSourceId: nil,
//                                              description: nil,
//                                              email: nil,
//                                              shipping: nil,
//                                              newSource: nil,
//                                              forCustomerId: customerId).serializedResponse()
//            
//            XCTAssertNotNil(updatedCustomer?.discount)
//            
//            let deletedDiscount = try drop?.stripe?.customer.deleteDiscount(onCustomer: updatedCustomer?.id ?? "").serializedResponse()
//            
//            XCTAssertTrue(deletedDiscount?.deleted ?? false)
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testDeleteCustomer() throws {
//        do {
//            let object = try drop?.stripe?.customer.delete(customer: customerId).serializedResponse()
//            XCTAssertEqual(object?.deleted, true)
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testRetrieveAllCustomers() throws {
//        do {
//            let object = try drop?.stripe?.customer.listAll(filter: nil).serializedResponse()
//            XCTAssertGreaterThanOrEqual(object!.items!.count, 1)
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testFilterCustomers() throws {
//        do {
//            let filter = StripeFilter()
//            
//            filter.limit = 1
//            
//            let customers = try drop?.stripe?.customer.listAll(filter: filter).serializedResponse()
//            
//            if let customerItems = customers?.items {
//                XCTAssertEqual(customerItems.count, 1)
//                XCTAssertNotNil(customerItems.first)
//            }
//            else {
//                XCTFail("Customers are not present")
//            }
//        }
//        catch let error as StripeError {
//            
//            switch error {
//            case .apiConnectionError:
//                XCTFail(error.localizedDescription)
//            case .apiError:
//                XCTFail(error.localizedDescription)
//            case .authenticationError:
//                XCTFail(error.localizedDescription)
//            case .cardError:
//                XCTFail(error.localizedDescription)
//            case .invalidRequestError:
//                XCTFail(error.localizedDescription)
//            case .rateLimitError:
//                XCTFail(error.localizedDescription)
//            case .validationError:
//                XCTFail(error.localizedDescription)
//            case .invalidSourceType:
//                XCTFail(error.localizedDescription)
//            default:
//                XCTFail(error.localizedDescription)
//            }
//        }
//        catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//}

