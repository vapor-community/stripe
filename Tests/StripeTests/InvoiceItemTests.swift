////
////  InvoiceTests.swift
////  Stripe
////
////  Created by Anthony Castelli on 9/5/17.
////
////
//
//import XCTest
//
//@testable import Stripe
//@testable import Vapor
//@testable import Random
//
//class InvoiceItemTests: XCTestCase {
//    
//    var drop: Droplet?
//    var customerId = ""
//    var invoiceItemId = ""
//    
//    override func setUp() {
//        super.setUp()
//        do {
//            self.drop = try self.makeDroplet()
//            
//            let paymentTokenSource = try self.drop?.stripe?.tokens.createCardToken(
//                withCardNumber: "4242 4242 4242 4242",
//                expirationMonth: 10,
//                expirationYear: 2018,
//                cvc: 123,
//                name: "Test Card",
//                customer: nil,
//                currency: nil
//            ).serializedResponse().id ?? ""
//            
//            self.customerId = try self.drop?.stripe?.customer.create(
//                accountBalance: nil,
//                businessVATId: nil,
//                coupon: nil,
//                defaultSource: nil,
//                description: nil,
//                email: nil,
//                shipping: nil,
//                source: paymentTokenSource
//            ).serializedResponse().id ?? ""
//            
//            self.invoiceItemId = try self.drop?.stripe?.invoiceItems.createItem(
//                forCustomer: self.customerId,
//                amount: 10_000, inCurrency: .usd
//            ).serializedResponse().id ?? ""
//            
//        } catch let error as StripeError {
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
//        } catch {
//            fatalError("Setup failed: \(error.localizedDescription)")
//        }
//    }
//    
//    override func tearDown() {
//        self.drop = nil
//        self.customerId = ""
//        self.invoiceItemId = ""
//        super.tearDown()
//    }
//    
//    func testCreatingItem() throws {
//        do {
//            let object = try self.drop?.stripe?.invoiceItems.createItem(
//                forCustomer: self.customerId,
//                amount: 10_000, inCurrency: .usd
//            ).serializedResponse()
//            XCTAssertNotNil(object)
//        } catch let error as StripeError {
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
//        } catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testFetchingItem() throws {
//        do {
//            let object = try self.drop?.stripe?.invoiceItems.fetch(invoiceItem: self.invoiceItemId).serializedResponse()
//            XCTAssertNotNil(object)
//        } catch let error as StripeError {
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
//        } catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testDeletingItem() throws {
//        do {
//            let object = try self.drop?.stripe?.invoiceItems.delete(invoiceItem: self.invoiceItemId)
//            XCTAssertNotNil(object)
//        } catch let error as StripeError {
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
//        } catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testUpdateItem() throws {
//        do {
//            let object = try self.drop?.stripe?.invoiceItems.update(
//                invoiceItem: self.invoiceItemId,
//                amount: 10_000,
//                description: "Update Invoice"
//            ).serializedResponse()
//            
//            XCTAssertEqual("Update Invoice", object?.description)
//            XCTAssertNotNil(object)
//        } catch let error as StripeError {
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
//        } catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//    
//    func testListAllItems() throws {
//        do {
//            let object = try self.drop?.stripe?.invoiceItems.listAll().serializedResponse()
//            XCTAssertNotNil(object)
//        } catch let error as StripeError {
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
//        } catch {
//            XCTFail(error.localizedDescription)
//        }
//    }
//}

