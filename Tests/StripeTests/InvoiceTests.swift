//
//  InvoiceTests.swift
//  Stripe
//
//  Created by Anthony Castelli on 9/5/17.
//
//

import XCTest

@testable import Stripe
@testable import Vapor
@testable import Random

class InvoiceTests: XCTestCase {
    
    var drop: Droplet?
    var customerId = ""
    var subscriptionId = ""
    var invoiceId = ""
    var invoiceItemId = ""
    
    override func setUp() {
        super.setUp()
        do {
            self.drop = try self.makeDroplet()
            
            let planId = try self.drop?.stripe?.plans.create(
                id: Data(bytes: URandom.bytes(count: 16)).base64String,
                amount: 10_00,
                currency: .usd,
                interval: .week,
                name: "Test Plan",
                intervalCount: 5,
                statementDescriptor: "Test Plan",
                trialPeriodDays: nil,
                metadata: nil
            ).serializedResponse().id ?? ""
            
            let paymentTokenSource = try self.drop?.stripe?.tokens.createCardToken(
                withCardNumber: "4242 4242 4242 4242",
                expirationMonth: 10,
                expirationYear: 2018,
                cvc: 123,
                name: "Test Card",
                customer: nil,
                currency: nil
            ).serializedResponse().id ?? ""
            
            self.customerId = try self.drop?.stripe?.customer.create(
                accountBalance: nil,
                businessVATId: nil,
                coupon: nil,
                defaultSource: nil,
                description: nil,
                email: nil,
                shipping: nil,
                source: paymentTokenSource
            ).serializedResponse().id ?? ""
            
            self.subscriptionId = try self.drop?.stripe?.subscriptions.create(
                forCustomer: self.customerId,
                plan: planId,
                applicationFeePercent: nil,
                couponId: nil,
                items: nil,
                quantity: nil,
                source: nil,
                taxPercent: nil,
                trialEnd: nil,
                trialPeriodDays: nil
            ).serializedResponse().id ?? ""
            
            self.invoiceItemId = try self.drop?.stripe?.invoiceItems.createItem(
                forCustomer: self.customerId,
                amount: 10_000, inCurrency: .usd
            ).serializedResponse().id ?? ""
            
            self.invoiceId = try drop?.stripe?.invoices.create(
                forCustomer: self.customerId,
                subscription: self.subscriptionId
            ).serializedResponse().id ?? ""
            
        } catch let error as StripeError {
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
        } catch {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    override func tearDown() {
        self.drop = nil
        self.customerId = ""
        self.subscriptionId = ""
        self.invoiceId = ""
        self.invoiceItemId = ""
        super.tearDown()
    }
    
    func testCreatingInvoice() throws {
        do {
            let object = try drop?.stripe?.invoices.create(
                forCustomer: self.customerId,
                subscription: self.subscriptionId
            ).serializedResponse()
            XCTAssertNotNil(object)
        } catch let error as StripeError {
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
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testFetchingInvoice() throws {
        do {
            print(self.invoiceId)
            let object = try drop?.stripe?.invoices.fetch(invoice: self.invoiceId).serializedResponse()
            XCTAssertNotNil(object)
        } catch let error as StripeError {
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
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testFetchingInvoiceItems() throws {
        do {
            let object = try drop?.stripe?.invoices.listItems(forInvoice: self.invoiceId)
            XCTAssertNotNil(object)
        } catch let error as StripeError {
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
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testFetchUpcomingInvoice() throws {
        do {
            let object = try drop?.stripe?.invoices.upcomingInvoice(forCustomer: self.customerId).serializedResponse()
            XCTAssertNotNil(object)
        } catch let error as StripeError {
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
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testUpdateInvoice() throws {
        do {
            let object = try drop?.stripe?.invoices.update(
                invoice: self.invoiceId,
                description: "Update Invoice"
            ).serializedResponse()
            
            XCTAssertEqual("Update Invoice", object?.description)
            XCTAssertNotNil(object)
        } catch let error as StripeError {
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
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
    func testListAllInvoices() throws {
        do {
            let object = try drop?.stripe?.invoices.listAll().serializedResponse()
            XCTAssertNotNil(object)
        } catch let error as StripeError {
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
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
}
