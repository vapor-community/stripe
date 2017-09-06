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

class InvoiceTests: XCTestCase {
    
    var drop: Droplet?
    var invoiceId: String = ""
    
    override func setUp() {
        super.setUp()
        do {
            self.drop = try self.makeDroplet()
            self.invoiceId = try drop?.stripe?.invoices.create(forCustomer: "").serializedResponse().id ?? ""
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
        }
        catch {
            fatalError("Setup failed: \(error.localizedDescription)")
        }
    }
    
    override func tearDown() {
        self.drop = nil
        self.invoiceId = ""
        super.tearDown()
    }
    
    func testExample() {
        
    }
    
}
